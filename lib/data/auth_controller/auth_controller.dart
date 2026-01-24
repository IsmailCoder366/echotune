import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../app/routes/app_routes.dart';

class AuthWrapperController extends GetxController {
  final AuthRepository _authRepo = AuthRepository();

  @override
  void onReady() {
    super.onReady();
    _checkAuthentication();
  }

  void _checkAuthentication() async {
    // 1. Give the splash screen a moment to breathe (optional 2s delay)
    await Future.delayed(const Duration(seconds: 2));

    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // 2. No user? Go to Landing
      Get.offAllNamed(Routes.landing);
    } else {
      // 3. User exists? Get their role from Firestore
      String? role = await _authRepo.getUserRole(user.uid);

      if (role == 'creator') {
        Get.offAllNamed(Routes.creatorMainScreen);
      } else {
        // Default to user home if role is 'user' or null
        Get.offAllNamed(Routes.userHome);
      }
    }
  }
}