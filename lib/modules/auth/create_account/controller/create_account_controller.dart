import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../data/repositories/auth_repository.dart';

class CreateAccountController extends GetxController {

  // Inject the Repository
  final AuthRepository _authRepo = AuthRepository();

  // Observables for state management
  var selectedType = 'User'.obs;
  var isSubmitting = false.obs;

  // Form fields - using TextEditingControllers for better form handling
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void setAccountType(String type) {
    selectedType.value = type;
  }

  void handleSubmit() async {
    // 1. Run Validations with your Toast package
    if (fullNameController.text.isEmpty) {
      AppValidators.showMessage("Full name is required");
      return;
    }
    if (!AppValidators.validateEmail(emailController.text)) return;
    if (!AppValidators.validatePassword(passwordController.text)) return;
    if (!AppValidators.validateConfirmPassword(
        passwordController.text, confirmPasswordController.text)) return;

    // 2. Start Submission
    isSubmitting.value = true;

    try {
      // 3. Call Repository with role (selectedType.value: 'User' or 'Creator')
      bool success = await _authRepo.signUp(
        emailController.text.trim(),
        passwordController.text.trim(),
        selectedType.value.toLowerCase(), // Save as 'user' or 'creator'
      );
      if (success) {
        AppValidators.showMessage("Account created successfully!", isError: false);

        // 4. Role-based Navigation
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
