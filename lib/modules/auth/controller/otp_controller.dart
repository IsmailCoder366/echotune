import 'package:get/get.dart';

class OtpVerificationController extends GetxController {
  var email = "".obs;
  var isVerifying = false.obs;

  // single variable to store full OTP from pin_code_fields
  var otp = "".obs;

  void setEmail(String value) {
    email.value = value;
  }

  /// Verify OTP
  void verifyCode() async {
    if (otp.value.length < 4) {
      Get.snackbar("Error", "Please enter a 4-digit code");
      return;
    }

    isVerifying.value = true;

    // simulate API call
    await Future.delayed(const Duration(seconds: 1));

    isVerifying.value = false;

    // TODO: call your API here or navigate to Reset Password screen
    Get.snackbar("Success", "OTP Verified: ${otp.value}");
  }
}
