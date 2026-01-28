import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../data/repositories/auth_repository.dart';

class CreateAccountController extends GetxController {
  final AuthRepository _authRepo = AuthRepository();

  var selectedType = 'User'.obs;
  var isSubmitting = false.obs;

  // NEW: Observable for password visibility
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void setAccountType(String type) {
    selectedType.value = type;
  }

  // NEW: Toggle function
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() { // NEW
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }
  void handleSubmit() async {
    if (fullNameController.text.isEmpty) {
      AppValidators.showMessage("Full name is required");
      return;
    }
    if (!AppValidators.validateEmail(emailController.text)) return;
    if (!AppValidators.validatePassword(passwordController.text)) return;
    if (!AppValidators.validateConfirmPassword(
        passwordController.text, confirmPasswordController.text)) return;

    isSubmitting.value = true;

    try {
      bool success = await _authRepo.signUp(
        emailController.text.trim(),
        passwordController.text.trim(),
        selectedType.value.toLowerCase(),
      );
      if (success) {
        AppValidators.showMessage("Account created successfully!", isError: false);
        if (selectedType.value == 'User') {
          Get.offAllNamed(Routes.userHome);
        } else {
          Get.offAllNamed(Routes.creatorMainScreen);
        }
      }
    } catch (e) {
      AppValidators.showMessage("An unexpected error occurred");
    } finally {
      isSubmitting.value = false;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}