import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../data/repositories/auth_repository.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepo = AuthRepository();

  // Observables
  var selectedType = 'User'.obs; // 'User' or 'Owner' (Creator)
  var isLoggingIn = false.obs;
  var isPasswordVisible = false.obs;

  // Text Controllers for the UI
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void setLoginType(String type) => selectedType.value = type;
  void togglePasswordVisibility() => isPasswordVisible.toggle();

  void handleLogin() async {
    if (!AppValidators.validateEmail(emailController.text.trim())) return;
    if (passwordController.text.isEmpty) {
      AppValidators.showMessage("Password is required");
      return;
    }

    isLoggingIn.value = true;

    try {
      var user = await _authRepo.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (user != null) {
        // FIX: Add '?' to the type or provide a default value
        // We use ?? 'user' to ensure it never stays null
        String? roleFromDb = await _authRepo.getUserRole(user.uid);
        String actualRole = roleFromDb ?? 'user';

        // UI uses 'Owner', DB uses 'creator'
        String selectedRole = selectedType.value == 'Owner' ? 'creator' : 'user';

        if (actualRole == selectedRole) {
          AppValidators.showMessage("Welcome back!", isError: false);

          // Role-based Navigation
          if (actualRole == 'user') {
            Get.offAllNamed(Routes.userHome);
          } else {
            Get.offAllNamed(Routes.creatorMainScreen);
          }
        } else {
          AppValidators.showMessage(
              "This account is registered as a $actualRole. Please switch the toggle above."
          );
        }
      }
    } catch (e) {
      // Log the actual error to your console to see what's happening
      debugPrint("Login Error: $e");
      AppValidators.showMessage("Login failed. Please check your credentials.");
    } finally {
      isLoggingIn.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}