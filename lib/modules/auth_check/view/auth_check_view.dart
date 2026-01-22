import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_check_controller.dart';

class AuthCheckView extends StatelessWidget {
  const AuthCheckView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthCheckController());

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
