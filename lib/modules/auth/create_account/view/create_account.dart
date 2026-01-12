import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../login/widgets/auth_toggle_tab.dart';
import '../../login/widgets/custom_text_field.dart';
import '../../login/widgets/primary_auth_button.dart';
import '../controller/create_account_controller.dart';
import '../widgets/auth_footer_link.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateAccountController controller = Get.put(CreateAccountController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text(
              "Create Account",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.black),
            ),
            const SizedBox(height: 20),

            // Role Selector
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Obx(() => Row(
                children: [
                  AuthToggleSwitch(
                    title: "User",
                    isActive: controller.selectedType.value == "User",
                    onTap: () => controller.setAccountType("User"),
                  ),
                  AuthToggleSwitch(
                    title: "Owner",
                    isActive: controller.selectedType.value == "Owner",
                    onTap: () => controller.setAccountType("Owner"),
                  ),
                ],
              )),
            ),

            const SizedBox(height: 25),

            AuthTextField(
              hint: "Name",
              onChanged: (v) => controller.fullName.value = v,
            ),
            const SizedBox(height: 16),

            AuthTextField(
              hint: "Email",
              onChanged: (v) => controller.email.value = v,
            ),
            const SizedBox(height: 16),

            AuthTextField(
              hint: "Password",
              isPassword: true,
              onChanged: (v) => controller.password.value = v,
            ),
            const SizedBox(height: 16),

            AuthTextField(
              hint: "Confirm password",
              isPassword: true,
              onChanged: (v) => controller.confirmPassword.value = v,
            ),

            const SizedBox(height: 30),

            Obx(() => PrimaryAuthButton(
              text: "Submit",
              isLoading: controller.isSubmitting.value,
              onPressed: () => controller.handleSubmit(),
            )),

            const SizedBox(height: 20),
            const Center(child: Text("Or", style: TextStyle(color: Colors.grey))),
            const SizedBox(height: 20),

            AuthFooterLink(
              leadText: "Already a member? ",
              linkText: "Login",
              onTap: () => Get.toNamed(Routes.login),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}