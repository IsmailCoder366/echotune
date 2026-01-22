import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';

class ResetPasswordController extends GetxController {
  var newPassword = ''.obs;
  var confirmPassword = ''.obs;

  var newPasswordVisible = false.obs;
  var confirmPasswordVisible = false.obs;



  Future<void> resetPassword() async {



    // navigate to login
    Get.offAllNamed(Routes.passwordChanged);
  }
}