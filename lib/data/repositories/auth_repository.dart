import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:echotune/core/utils/app_validators.dart';
import 'package:flutter/material.dart';
import '../../core/models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  /// Firebase Exception
  void _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      // --- Login/Signup Errors ---
      case 'user-not-found':
        AppValidators.showMessage("No account exists with this email.");
        break;
      case 'wrong-password':
        AppValidators.showMessage("Incorrect password. Please try again.");
        break;
      case 'email-already-in-use':
        AppValidators.showMessage(
          "This email is already registered. Please login.",
        );
        break;
      case 'invalid-email':
        AppValidators.showMessage("The email address is badly formatted.");
        break;
      case 'user-disabled':
        AppValidators.showMessage(
          "This user account has been disabled by admin.",
        );
        break;

      // --- Password Errors ---
      case 'weak-password':
        AppValidators.showMessage(
          "The password is too weak. Use a stronger one.",
        );
        break;

      // --- Security/Rate Limiting ---
      case 'too-many-requests':
        AppValidators.showMessage(
          "Too many failed attempts. Account temporarily locked.",
        );
        break;
      case 'operation-not-allowed':
        AppValidators.showMessage(
          "Email/Password accounts are not enabled in Firebase.",
        );
        break;

      // --- Network/System Errors ---
      case 'network-request-failed':
        AppValidators.showMessage(
          "Check your internet connection and try again.",
        );
        break;
      case 'internal-error':
        AppValidators.showMessage(
          "Internal server error. Please try again later.",
        );
        break;

      // --- Credential Errors (Specific to modern Firebase versions) ---
      case 'invalid-credential':
        AppValidators.showMessage(
          "Invalid credentials. The email or password may be wrong.",
        );
        break;

      default:
        AppValidators.showMessage(
          e.message ?? "Authentication failed. Please try again.",
        );
    }
  }

  /// Login
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return null;
    }
  }

  /// Signup with dynamic collection based on role
  Future<bool> signUp(String email, String password, String role) async {
    try {
      // 1. Create the Auth Account
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password
      );

      if (credential.user != null) {
        // 2. Create the Model
        UserModel newUser = UserModel(
          uid: credential.user!.uid,
          email: email,
          role: role,
          name: "",
          profileImage: "",
        );

        // 3. Determine the collection name dynamically
        // If role is 'owner', save to 'creators', otherwise save to 'users'
        String collectionName = (role.toLowerCase() == "owner") ? "creators" : "users";

        // 4. Save to the specific collection
        await _db
            .collection(collectionName)
            .doc(credential.user!.uid)
            .set(newUser.toMap());

        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return false;
    } catch (e) {
      debugPrint("FIRESTORE SIGNUP ERROR: $e");
      AppValidators.showMessage("Account created, but database failed. Try logging in.");
      return true;
    }
  }

  /// Reset Password (lib/data/repositories/auth_repository.dart)
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // Remove the showMessage from here to avoid the double popup
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      rethrow; // Important: rethrow so the Controller knows an error happened
    }
  }

  /// Decide Role
  Future<String?> getUserRole(String uid) async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return doc['role'] as String?;
      }
    } catch (e) {
      debugPrint("Error fetching role: $e");
    }
    return null;
  }

  /// Logout
  Future<void> logout() async {
    try {
      await _auth.signOut();
      // Logic for redirection will be handled in the Controller
    } catch (e) {
      AppValidators.showMessage("Logout failed. Please try again.");
      rethrow;
    }
  }

  /// --- NEW: Update User Profile ---
  /// This function updates the user's name and their profile image link in Firestore
  /// Updated Update Profile to include Bank Info
  Future<void> updateUserProfile({
    required String uid,
    required String newName,
    required String imageUrl,
    required String accountNumber,
    required String ifscCode,
  }) async {
    try {
      // Using set with merge: true is safer than update
      await _db.collection('users').doc(uid).set({
        'name': newName,
        'profileImage': imageUrl,
        'accountNumber': accountNumber,
        'ifscCode': ifscCode,
        'lastUpdated': FieldValue.serverTimestamp(), // Good for debugging
      }, SetOptions(merge: true));

      debugPrint("Firestore update successful for UID: $uid");
    } catch (e) {
      debugPrint("FIRESTORE ERROR: $e"); // CHECK YOUR CONSOLE FOR THIS!
      AppValidators.showMessage("Could not update profile details.");
      rethrow;
    }
  }

  /// Change Password Function
  Future<void> changePassword(String newPassword) async {
    try {
      await _auth.currentUser?.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      rethrow;
    }
  }

  /// --- NEW: Get Complete User Data ---
  /// This fetches the full document so we can fill the text boxes in the UI
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>?;
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    }
    return null;
  }
}
