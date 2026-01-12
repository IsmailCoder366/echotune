import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';

class ForgotPasswordController extends GetxController {

  var email = ''.obs;
  var isLoading = false.obs;

  void sendCode() async {
    isLoading.value = true;

    // simulate API call
    await Future.delayed(const Duration(seconds: 1));

    isLoading.value = false;
// Navigate to OTP screen
    Get.toNamed(Routes.otpScreen);
    // For now only show success snackbar
    Get.snackbar("Success", "Reset code sent to email");
  }
}
