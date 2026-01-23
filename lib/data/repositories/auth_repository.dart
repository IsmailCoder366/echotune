import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:echotune/core/utils/app_validators.dart';

import '../../core/models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Handles Firebase Errors and shows the appropriate Toast
  void _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
    case 'user-not-found':
    AppValidators.showMessage("No user found with this email.");
    break;
    case 'wrong-password':
    AppValidators.showMessage("Incorrect password.");
    break;
    case 'email-already-in-use':
    AppValidators.showMessage("This email is already registered.");
    break;
    case 'weak-password':
    AppValidators.showMessage("The password provided is too weak.");
    break;
    default:
    AppValidators.showMessage(e.message ?? "An error occurred.");
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