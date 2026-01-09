import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../view/otp_verification_view.dart';

class CreateAccountController extends GetxController {
  // Observables for state management
  var selectedType = 'User'.obs;
  var isSubmitting = false.obs;

  // Form fields
  var fullName = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;

  void setAccountType(String type) {
    selectedType.value = type;
  }

  void handleSubmit() async {
    isSubmitting.value = true;

    // simulate delay (API call later)
    await Future.delayed(const Duration(seconds: 1));

    // simple navigation logic (no validation)
    if (selectedType.value == 'User') {
      Get.offAllNamed(Routes.otpScreen);
    } else {
      Get.offAllNamed(Routes.creatorHome);
    }

    isSubmitting.value = false;
  }
}
