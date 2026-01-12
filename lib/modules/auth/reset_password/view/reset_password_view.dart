import 'package:echotune/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/reset_password_controller.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text("Login"),
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 10),
            const Text(
              "Reset Password",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),
            const Text(
              "Please type something you'll remember",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),

            const SizedBox(height: 25),

            const Text("New Password"),
            const SizedBox(height: 6),

            Obx(() => TextField(
              obscureText: !controller.newPasswordVisible.value,
              onChanged: (v) => controller.newPassword.value = v,
              decoration: InputDecoration(
                hintText: "Must be 8 characters",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.newPasswordVisible.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    controller.newPasswordVisible.value =
                    !controller.newPasswordVisible.value;
                  },
                ),
              ),
            )),

            const SizedBox(height: 20),

            const Text("Confirm New Password"),
            const SizedBox(height: 6),

            Obx(() => TextField(
              obscureText: !controller.confirmPasswordVisible.value,
              onChanged: (v) => controller.confirmPassword.value = v,
              decoration: InputDecoration(
                hintText: "Repeat password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.confirmPasswordVisible.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    controller.confirmPasswordVisible.value =
                    !controller.confirmPasswordVisible.value;
                  },
                ),
              ),
            )),

            const SizedBox(height: 25),

            Obx(() => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () => controller.resetPassword(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.authColor,
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: controller.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  "Reset Password",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            )),

            const Spacer(),

            Center(
              child: GestureDetector(
                onTap: () => Get.offAllNamed('/login'),
                child: const Text.rich(
                  TextSpan(
                    text: "Remember password? ",
                    children: [
                      TextSpan(
                        text: "Log in",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
