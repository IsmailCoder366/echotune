import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

class LoginController extends GetxController {
  // Observables for the toggle and loading state
  var selectedType = 'User'.obs;
  var isLoggingIn = false.obs;

  // Form fields
  var email = ''.obs;
  var password = ''.obs;

  void setLoginType(String type) => selectedType.value = type;

  void handleLogin() async {
    // 1. Show loading state to satisfy Obx requirement
    isLoggingIn.value = true;

    // Simulate a network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // 2. Logic to navigate to the correct Home Screen
    if (selectedType.value == 'User') {
      print("Navigating to User Home...");
      Get.offAllNamed(Routes.userHome);
    } else {
      print("Navigating to Creator Home...");
      // Ensure Routes.creatorHome is uncommented in your AppPages
      Get.offAllNamed(Routes.creatorHome);
    }

    isLoggingIn.value = false;
  }
}