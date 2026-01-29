import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_info_controller.dart';

class UserInfoTab extends StatelessWidget {
  const UserInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Initialize the Controller
    final UserInfoController controller = Get.put(UserInfoController());

    return Scaffold(
      backgroundColor: Colors.white,
      // Added a Refresh Action just in case
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => controller.fetchUserData(),
              icon: const Icon(Icons.refresh, color: Colors.black)
          )
        ],
      ),
      body: Obx(() {
        // Show a big spinner if the initial data is still being fetched
        // (You can add a 'isLoading' bool to the controller if you want to be precise)
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Profile Section
              _buildProfileUploadSection(controller),

              const SizedBox(height: 20),

              // 2. Personal Info
              _buildInputField("Name", "Enter Name", controller.nameController),
              // Email is usually kept disabled to prevent auth issues
              _buildInputField("Email", "Enter Email", controller.emailController, enabled: false),

              const SizedBox(height: 20),
              const Text('Change Password', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              _buildInputField("New Password", "Enter New Password", controller.newPasswordController, isPassword: true),
              _buildInputField("Confirm Password", "Enter Confirm Password", controller.confirmPasswordController, isPassword: true),

              const SizedBox(height: 20),
              const Text('Bank Account', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              _buildInputField("Account Number", "Enter Account", controller.accountController),
              _buildInputField("Confirm Account Number", "Confirm Enter Account", controller.confirmAccountController),
              _buildInputField("IFSC Code", "Enter IFSC Number", controller.ifscController),

              const SizedBox(height: 30),

              // 3. Update Button with Loading Logic
              controller.isSaving.value
                  ? const Center(child: CircularProgressIndicator(color: Colors.black))
                  : UpdateButton(onTap: () => controller.saveFullProfile()),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProfileUploadSection(UserInfoController controller) {
    return Obx(() => Row(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: Colors.grey[200],
          // Dynamically switch between the new URL and the default asset
          backgroundImage: controller.profileImageUrl.value.isNotEmpty
              ? NetworkImage(controller.profileImageUrl.value)
              : const AssetImage('assets/images/image.png') as ImageProvider,
          // Optional: show a loading spinner over the avatar while uploading
          child: controller.isUploadingImage.value
              ? const CircularProgressIndicator(color: Colors.black, strokeWidth: 2)
              : null,
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Profile Picture', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const Text('Cloudinary Storage Enabled', style: TextStyle(fontSize: 10, color: Colors.green)),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: controller.isUploadingImage.value ? null : () => controller.pickImage(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                child: Text(
                    controller.isUploadingImage.value ? 'Uploading...' : 'Upload New Photo',
                    style: const TextStyle(color: Colors.white)
                ),
              )
            ],
          ),
        )
      ],
    ));
  }

  Widget _buildInputField(String label, String hint, TextEditingController txtController, {bool enabled = true, bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 5),
        TextFormField(
          controller: txtController,
          enabled: enabled,
          obscureText: isPassword,
          style: TextStyle(color: enabled ? Colors.black : Colors.grey),
          decoration: InputDecoration(
            hintText: hint,
            filled: !enabled,
            fillColor: enabled ? Colors.transparent : Colors.grey[100],
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black12)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black12)),
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
    return Material(
      color: Colors.black,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
            height: 55,
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text('Save Changes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))
        ),
      ),
    );
  }
}