import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';

class ForgotPasswordController extends GetxController {

  var email = ''.obs;


  void sendCode() async {

    Get.toNamed(Routes.otpScreen);

  }
}
