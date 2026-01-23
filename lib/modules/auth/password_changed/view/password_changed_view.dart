
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/constants/app_colors.dart';
import '../controller/password_changed_controller.dart';

class PasswordChangedView extends StatelessWidget {
  const PasswordChangedView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PasswordChangedController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Green check circle
            const CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage(
                  'assets/images/Change-Confirm-Icon.png'),
            ),

            const SizedBox(height: 30),

            const Text(
              "Password Changed",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            const Text(
              "Your password has been changed\nsuccessfully",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.goToLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.authColor,
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Back to Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
