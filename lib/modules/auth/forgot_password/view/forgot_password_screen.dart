import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../login/widgets/custom_text_field.dart';
import '../../login/widgets/primary_auth_button.dart'; // Ensure correct path
import '../controller/forgot_password_controller.dart';



class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller is initialized here
    final controller = Get.put(ForgotPasswordController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        // Changed to match the screen's purpose
        title: const Text(
          "Forgot Password",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24), // Consistent padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text(
                "Reset Password",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Don't worry! It happens. Please enter the email associated with your account.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 32),

              const Text(
                "Email Address",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),

              // Using your custom AuthTextField linked to emailController
              AuthTextField(
                hint: "Enter your Email address",
                controller: controller.emailController,
              ),

              const SizedBox(height: 32),

              // Using your PrimaryAuthButton to handle loading state
              Obx(() => PrimaryAuthButton(
                text: "Send Reset Link",
                isLoading: controller.isSending.value,
                onPressed: () => controller.handleResetPassword(),
              )),

              const SizedBox(height: 140),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Remember password? "),
                    GestureDetector(
                      onTap: () => Get.offNamed(Routes.login),
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xffE34D4D), // Matching your theme
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}