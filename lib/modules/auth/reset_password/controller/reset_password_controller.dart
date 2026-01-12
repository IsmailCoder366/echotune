import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';

class ResetPasswordController extends GetxController {
  var newPassword = ''.obs;
  var confirmPassword = ''.obs;

  var newPasswordVisible = false.obs;
  var confirmPasswordVisible = false.obs;

  var isLoading = false.obs;

  Future<void> resetPassword() async {
    isLoading.value = true;

    // simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    isLoading.value = false;

    // success response
    Get.snackbar("Success", "Password reset successfully");

    // navigate to login
    Get.offAllNamed(Routes.passwordChanged);
  }
}