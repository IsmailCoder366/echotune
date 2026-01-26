import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_info_controller.dart'; // Ensure this path is correct

class UserInfoTab extends StatelessWidget {
  const UserInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Find the Manager (Controller)
    final UserInfoController controller = Get.put(UserInfoController());

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // We wrap this in Obx so the profile image updates instantly
          Obx(() => _buildProfileUploadSection(controller)),

          const SizedBox(height: 20),
          _buildInputField("Name", "Enter Name", controller.nameController),
          _buildInputField("Email", "Enter Email", controller.emailController, enabled: false),

          const SizedBox(height: 20),
          const Text('Change Password', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          _buildInputField("Old Password", "Enter Old Password", controller.oldPasswordController, isPassword: true),
          _buildInputField("New Password", "Enter New Password", controller.newPasswordController, isPassword: true),
          _buildInputField("Confirm Password", "Enter Confirm Password", controller.confirmPasswordController, isPassword: true),

          const SizedBox(height: 20),
          const Text('Bank Account', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          _buildInputField("Account Number", "Enter Account", controller.accountController),
          _buildInputField("Confirm Account Number", "Confirm Enter Account", controller.confirmAccountController),
          _buildInputField("IFSC Code", "Enter IFSC Number", controller.ifscController),

          const SizedBox(height: 30),

          // 2. The Update Button with Loading Logic
          Obx(() => controller.isSaving.value
              ? const Center(child: CircularProgressIndicator(color: Colors.black))
              : UpdateButton(onTap: () => controller.saveFullProfile())),
        ],
      ),
    );
  }

  Widget _buildProfileUploadSection(UserInfoController controller) {
    return Row(
      children: [
        // Show Cloudinary image if it exists, otherwise show default asset
        CircleAvatar(
          radius: 30,
          backgroundImage: controller.profileImageUrl.value.isNotEmpty
              ? NetworkImage(controller.profileImageUrl.value)
              : const AssetImage('assets/images/image.png') as ImageProvider,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Profile Picture', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const Text('Recommended memory size is less than 12MB', style: TextStyle(fontSize: 10)),
              const SizedBox(height: 10),
              ElevatedButton(
                // 3. Connect the Upload Button
                onPressed: controller.isUploadingImage.value ? null : () => controller.pickImage(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                child: Text(
                    controller.isUploadingImage.value ? 'Uploading...' : 'Upload',
                    style: const TextStyle(color: Colors.white)
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  // 4. Input Field now takes a Controller
  Widget _buildInputField(String label, String hint, TextEditingController txtController, {bool enabled = true, bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(label),
        const SizedBox(height: 5),
        TextFormField(
          controller: txtController,
          enabled: enabled,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
          ),
        ),
      ],
    );
  }
}

class UpdateButton extends StatelessWidget {
  final VoidCallback onTap;
  const UpdateButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell( // Changed to InkWell for better click handling
      onTap: onTap,
      child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10)
          ),
          child: const Center(
              child: Text('Update', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))
          )
      ),
    );
  }
}