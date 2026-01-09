import 'package:echotune/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../controller/login_controller.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Login with email', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            const SizedBox(height: 30),

            // 1. USER/OWNER TOGGLE
            Obx(() => Container(
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
            )),

            const SizedBox(height: 32),

            // 2. EMAIL FIELD
            _buildInputField(
              hint: "Email",
              onChanged: (val) => controller.email.value = val,
            ),

            const SizedBox(height: 20),

            // 3. PASSWORD FIELD
            _buildInputField(

              hint: "Password",
              isPassword: true,
              onChanged: (val) => controller.password.value = val,
            ),

            // 4. FORGOT PASSWORD [cite: 8]
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Get.toNamed(Routes.forgotPassword);
                },
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.black, fontSize: 13, decoration: TextDecoration.underline),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 5. SUBMIT BUTTON
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () => controller.handleLogin(),
                style: ElevatedButton.styleFrom(
                  backgroundColor:  AppColors.authColor, // Primary Gold [cite: 9]
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Obx(() {
                  // By accessing isLoggingIn.value, GetX won't throw the "improper use" error
                  return Text(
                    controller.isLoggingIn.value ? "Loading..." : "Login",
                    style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 24),
            const Text("Or", style: TextStyle(color: Colors.black)), // Divider requirement [cite: 12]
            const SizedBox(height: 24),

            // 6. GOOGLE LOGIN
            _buildSocialButton(),

            const SizedBox(height: 32),

            // 7. FOOTER LINKS [cite: 11]
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 Text("Not a member? ", style: TextStyle(color: Colors.black)),
                GestureDetector(
                  onTap: () {},
                  child:  TextButton(
                    onPressed: (){
                      Get.toNamed(Routes.createAccount);
                    },
                    child: Text("Sign up",style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                  width: 1
                )
              ),
              child: Center(child: TextButton(
                  onPressed: (){
                    Get.toNamed(Routes.createAccount);
                  },
                  child: Text('Create Account', style: TextStyle(color: Colors.black),))),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- HELPER WIDGETS ---

  Widget _buildToggleTab(String title, LoginController controller) {
    bool isActive = controller.selectedType.value == title;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setLoginType(title),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
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
            hintStyle: const TextStyle(color: Colors.black, fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color:  Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color:  Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton() {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.g_mobiledata, size: 32, color: Colors.black), // Placeholder Google Icon
            const SizedBox(width: 8),
            const Text(
              "Continue with Google",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}