import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/auth_controller/auth_controller.dart'; // Create this next

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We initialize the controller here if not done in main.dart
    Get.put(AuthWrapperController());

    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CircularProgressIndicator(color: Color(0xffE34D4D)),
          ],
        ),
      ),
    );
  }
}