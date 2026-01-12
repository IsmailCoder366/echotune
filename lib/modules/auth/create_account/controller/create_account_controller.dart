import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../app/routes/app_routes.dart';
import '../../otp_verification/view/otp_verification_view.dart';

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


    // simple navigation logic (no validation)
    if (selectedType.value == 'User') {
      Get.offAllNamed(Routes.userHome);
    }
    else{
      Get.offAllNamed(Routes.creatorHome);
    }

    isSubmitting.value = false;
  }
}
