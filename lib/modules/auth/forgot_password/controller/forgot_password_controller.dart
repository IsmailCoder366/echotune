import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../data/repositories/auth_repository.dart';

class ForgotPasswordController extends GetxController {
  final AuthRepository _authRepo = AuthRepository();

  // Controller for the email input field
  final emailController = TextEditingController();

  // Observable for loading state
  var isSending = false.obs;

  void handleResetPassword() async {
    if (!AppValidators.validateEmail(emailController.text.trim())) return;

    isSending.value = true;

    try {
      // 1. Wait for the API hit to finish
      await _authRepo.resetPassword(emailController.text.trim());

      // 2. Show the success message (ONLY HERE)
      AppValidators.showMessage(
          "Reset link sent! Please check your email.",
          isError: false
      );

      // 3. Clear fields and go back
      // We use a small delay so the user actually sees the Success Snackbar
      await Future.delayed(const Duration(milliseconds: 2000));

      // Clear the email field so it's fresh if they come back
      emailController.clear();

      // Move back to Login
      Get.toNamed('/login');

    } catch (e) {
      // No need to showMessage here, the repo's _handleAuthError did it!
      debugPrint("Reset flow stopped due to error");
    } finally {
      isSending.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}