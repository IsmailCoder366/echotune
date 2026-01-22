// lib/core/services/auth_service.dart
import 'package:get/get.dart';

class AuthServices extends GetxService {
  // Observable to track login status
  var isLoggedIn = false.obs;

  void login() => isLoggedIn.value = true;

  void logout() => isLoggedIn.value = false;
}
