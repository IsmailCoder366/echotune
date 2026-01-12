import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';

class OtpVerificationController extends GetxController {
  var email = "".obs;
  var isVerifying = false.obs;

  var otp = "".obs;

  void setEmail(String value) {
    email.value = value;
  }

  /// Verify OTP
  Future<void> verifyCode() async {
    isVerifying.value = true;

    // simulate API call
    await Future.delayed(const Duration(seconds: 1));

    isVerifying.value = false;

    // 👉 after success, go to reset password screen
    Get.offNamed(Routes.resetPasswordScreen);
  }
}
