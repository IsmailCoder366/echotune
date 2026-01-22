import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';

class OtpVerificationController extends GetxController {
  var email = "".obs;


  var otp = "".obs;

  void setEmail(String value) {
    email.value = value;
  }

  /// Verify OTP
  Future<void> verifyCode() async {

    Get.offNamed(Routes.resetPasswordScreen);
  }
}
