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
    // 1. Validate the email first
    if (!AppValidators.validateEmail(emailController.text.trim())) return;

    isSending.value = true;

    try {
      // 2. Call the repository to send the Firebase reset email
      await _authRepo.resetPassword(emailController.text.trim());

      // Success message is handled inside the repository or here
      AppValidators.showMessage(
          "Password reset link sent to your email!",
          isError: false
      );

      // Optionally navigate back to login after a delay
      Future.delayed(const Duration(seconds: 2), () {
        Get.back();
      });

    } catch (e) {
      AppValidators.showMessage("Failed to send reset email. Please try again.");
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