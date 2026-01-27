import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileDisplayScreen extends StatelessWidget {
  const ProfileDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the data passed from the controller
    final Map<String, dynamic> data = Get.arguments ?? {};

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile Stored Info", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Removes back arrow
        actions: [
          // The "Cross" button to go back to Home Screen
          IconButton(
            onPressed: () => Get.offAllNamed('/userHome'), // Adjust to your home route name
            icon: const Icon(Icons.close, color: Colors.black, size: 30),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: data['profileImage'] != null && data['profileImage'].isNotEmpty
                    ? NetworkImage(data['profileImage'])
                    : const AssetImage('assets/images/image.png') as ImageProvider,
              ),
            ),
            const SizedBox(height: 30),
            const Text("Database Details", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Divider(),
            _buildInfoTile("Full Name", data['name'] ?? "N/A"),
            _buildInfoTile("Email Address", data['email'] ?? "N/A"),
            _buildInfoTile("Account Role", data['role']?.toUpperCase() ?? "USER"),
            _buildInfoTile("Account Number", data['accountNumber'] ?? "N/A"),
            _buildInfoTile("IFSC Code", data['ifscCode'] ?? "N/A"),
            const Spacer(),
            const Center(
              child: Text(
                "Data successfully synced with Firestore",
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}