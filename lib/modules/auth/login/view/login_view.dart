import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/utils/app_validators.dart';
import '../../create_account/widgets/auth_footer_link.dart';
import '../controller/login_controller.dart';
import '../widgets/auth_toggle_tab.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_auth_button.dart';
import '../widgets/social_login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Injecting the controller
    final LoginController controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Obx(
                  () => Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    AuthToggleSwitch(
                      title: "User",
                      isActive: controller.selectedType.value == "User",
                      onTap: () => controller.setLoginType("User"),
                    ),
                    AuthToggleSwitch(
                      title: "Owner",
                      isActive: controller.selectedType.value == "Owner",
                      onTap: () => controller.setLoginType("Owner"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            AuthTextField(
              hint: "Email",
              controller: controller.emailController,
            ),
            const SizedBox(height: 20),

            // FIXED: Password Field with Visibility Toggle
            Obx(() => AuthTextField(
              hint: "Password",
              isPassword: true,
              obscureText: !controller.isPasswordVisible.value, // Bind to controller
              onSuffixIconTap: () => controller.togglePasswordVisibility(), // Bind to function
              controller: controller.passwordController,
            )),

            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Get.toNamed(Routes.forgotPassword),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Button now observes the isLoggingIn state
            Obx(() => PrimaryAuthButton(
              text: "Login",
              isLoading: controller.isLoggingIn.value, // Pass the loading state
              onPressed: () => controller.handleLogin(),
            )),

            const SizedBox(height: 30),
            SocialAuthButton(
              text: "Continue with Google",
              image: 'assets/icons/google.png',
              onTap: () {
                // You can trigger your Google Auth logic here later
                AppValidators.showMessage("Google Login coming soon!", isError: false);
              },
            ),

            const SizedBox(height: 20),
            const Center(
              child: Text("Or", style: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 20),

            AuthFooterLink(
              leadText: 'Not a member? ',
              linkText: 'Signup',
              onTap: () => Get.toNamed(Routes.createAccount),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}