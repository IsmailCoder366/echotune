import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:echotune/core/utils/app_validators.dart';

import '../../core/models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;


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
        AppValidators.showMessage("This email is already registered. Please login.");
        break;
      case 'invalid-email':
        AppValidators.showMessage("The email address is badly formatted.");
        break;
      case 'user-disabled':
        AppValidators.showMessage("This user account has been disabled by admin.");
        break;

    // --- Password Errors ---
      case 'weak-password':
        AppValidators.showMessage("The password is too weak. Use a stronger one.");
        break;

    // --- Security/Rate Limiting ---
      case 'too-many-requests':
        AppValidators.showMessage("Too many failed attempts. Account temporarily locked.");
        break;
      case 'operation-not-allowed':
        AppValidators.showMessage("Email/Password accounts are not enabled in Firebase.");
        break;

    // --- Network/System Errors ---
      case 'network-request-failed':
        AppValidators.showMessage("Check your internet connection and try again.");
        break;
      case 'internal-error':
        AppValidators.showMessage("Internal server error. Please try again later.");
        break;

    // --- Credential Errors (Specific to modern Firebase versions) ---
      case 'invalid-credential':
        AppValidators.showMessage("Invalid credentials. The email or password may be wrong.");
        break;

      default:
        AppValidators.showMessage(e.message ?? "Authentication failed. Please try again.");
    }
  }


  /// Login
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return null;
    }
  }


  /// Signup
  Future<bool> signUp(String email, String password, String role) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password
      );

      // Save user role in Firestore
      UserModel newUser = UserModel(uid: credential.user!.uid, email: email, role: role);
      await _db.collection('users').doc(credential.user!.uid).set(newUser.toMap());

      return true;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return false;
    }
  }


  /// Reset Password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      AppValidators.showMessage("Reset link sent!", isError: false);
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    }
  }

  /// Decide Role
  Future<String> getUserRole(String uid) async {
    DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
    return doc['role'] ?? 'user';
  }
}