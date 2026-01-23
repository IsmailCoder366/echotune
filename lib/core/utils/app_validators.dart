import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppValidators {
  static void showMessage(String message, {bool isError = true}) {
    Get.snackbar(
      isError ? "Required" : "Success",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: isError ? Colors.redAccent : Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(15),
      duration: const Duration(seconds: 3),
    );
  }

  /// Full Name Validation
  static bool validateName(String name) {
    if (name.trim().isEmpty) {
      showMessage("Please enter your full name");
      return false;
    }
    if (name.trim().length < 3) {
      showMessage("Name must be at least 3 characters long");
      return false;
    }
    return true;
  }

  /// Enhanced Email Validation
  static bool validateEmail(String email) {
    if (email.isEmpty) {
      showMessage("Email cannot be empty");
      return false;
    }
    // Stricter regex for email
    final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    if (!emailRegex.hasMatch(email)) {
      showMessage("Enter a valid email (e.g., name@example.com)");
      return false;
    }
    return true;
  }

  /// Enhanced Password Validation
  static bool validatePassword(String password) {
    if (password.isEmpty) {
      showMessage("Password cannot be empty");
      return false;
    }
    if (password.length < 8) {
      showMessage("Password must be at least 8 characters long");
      return false;
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      showMessage("Password must contain at least one uppercase letter");
      return false;
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      showMessage("Password must contain at least one number");
      return false;
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      showMessage("Password must contain at least one special character");
      return false;
    }
    return true;
  }

  /// Signup Confirm Password Validation
  static bool validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      showMessage("Please confirm your password");
      return false;
    }
    if (confirmPassword != password) {
      showMessage("Passwords do not match");
      return false;
    }
    return true;
  }
}