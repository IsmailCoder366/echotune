import 'package:get/get.dart';
import '../repository/auth_repository.dart';

class AuthCheckController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final isLoggedIn = await _authRepository.isLoggedIn();
    final userType = await _authRepository.getUserType(); // "user" or "creator"

    await Future.delayed(const Duration(milliseconds: 400));

    if (isLoggedIn) {
      if (userType == "creator") {
        Get.offAllNamed('/creatorHome');
      } else {
        Get.offAllNamed('/userHome');
      }
    } else {
      Get.offAllNamed('/landing');
    }
  }
}
