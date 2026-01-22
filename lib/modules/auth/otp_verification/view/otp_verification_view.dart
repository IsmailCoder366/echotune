import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../controller/otp_controller.dart';

class OtpVerificationView extends GetView<OtpVerificationController> {
  const OtpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OtpVerificationController());
    final TextEditingController otpController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text("Login", style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Please Check Your Email",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            Center(
                child: Text(
                  "We've sent a code to ${controller.email.value}",
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            const SizedBox(height: 24),

            /// PIN CODE FIELDS
            PinCodeTextField(
              appContext: context,
              controller: otpController,
              length: 4, // 4-digit OTP
              keyboardType: TextInputType.number,
              autoFocus: true,
              enableActiveFill: true,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10),
                fieldHeight: 60,
                fieldWidth: 60,
                activeFillColor: Colors.white,
                selectedFillColor: Colors.white,
                inactiveFillColor: Colors.white,
                activeColor: Colors.black,
                selectedColor: Colors.black,
                inactiveColor: Colors.grey,
              ),
            ),

            const SizedBox(height: 24),

            /// VERIFY BUTTON
             SizedBox(
                width: double.infinity,
                height: 48,
                child: TextButton(
                  onPressed: controller.verifyCode,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xffE34D4D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Verify",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),


            const SizedBox(height: 16),
            const Center(
              child: Text(
                "Send code again   00:20",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
