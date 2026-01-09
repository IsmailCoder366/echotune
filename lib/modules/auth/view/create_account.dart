import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../controller/create_account_controller.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateAccountController controller = Get.put(CreateAccountController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),


        body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            const SizedBox(height: 30),
            const Text(
              "Create Account",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // 🔥 FIXED — removed unnecessary Obx
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _buildToggleTab("User", controller),
                  _buildToggleTab("Owner", controller),
                ],
              ),
            ),

            const SizedBox(height: 25),

            _buildInputField(

              hint: "name",
              onChanged: (v) => controller.fullName.value = v,
            ),
            const SizedBox(height: 16),

            _buildInputField(

              hint: "email",
              onChanged: (v) => controller.email.value = v,
            ),
            const SizedBox(height: 16),

            _buildInputField(

              hint: "password",
              isPassword: true,
              onChanged: (v) => controller.password.value = v,
            ),
            const SizedBox(height: 16),

            _buildInputField(

              hint: "Confirm password",
              isPassword: true,
              onChanged: (v) => controller.confirmPassword.value = v,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () => controller.handleSubmit(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.authColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),

                // ✅ This Obx is valid (uses isSubmitting)
                child: Obx(
                      () => Text(
                    controller.isSubmitting.value ? "Processing..." : "Submit",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text("Or", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already a member? "),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.login),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleTab(String title, CreateAccountController controller) {
    return Obx(() {
      bool isActive = controller.selectedType.value == title;

      return Expanded(
        child: GestureDetector(
          onTap: () => controller.setAccountType(title),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: isActive ? Colors.black : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isActive ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildInputField({

    required String hint,
    bool isPassword = false,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          obscureText: isPassword,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
          hintStyle: TextStyle(color: Color(0XFF9D9C9C)),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
          ),
        ),
      ],
    );
  }
}
