import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';

class LoginController extends GetxController {
  // Observables for the toggle and loading state
  var selectedType = 'User'.obs;
  var isLoggingIn = false.obs;

  // Form fields
  var email = ''.obs;
  var password = ''.obs;

  void setLoginType(String type) => selectedType.value = type;

  void handleLogin() async {
    if (selectedType.value == 'User') {
      Get.offAllNamed(Routes.userHome);
    } else {
      Get.offAllNamed(Routes.creatorMainScreen);
    }

    isLoggingIn.value = false;
  }
}