import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/creator_dashboard_controller.dart';
import '../widgets/build_action_card.dart';
import '../widgets/build_analytic_section.dart';
import '../widgets/build_profile_header.dart';

class AdminDashboardView extends StatelessWidget {
  // Use Get.find if the controller is already initialized in the Main Shell,
  // or Get.put if this view is sometimes used standalone.
  final controller = Get.put(AdminDashboardController());

  @override
  Widget build(BuildContext context) {
    // REMOVED Obx() because there are no observables being used in this static layout
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        title: const Text("ECHOTUNE",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: const [
          Icon(Icons.settings_outlined, color: Colors.white),
          SizedBox(width: 10),
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
          SizedBox(width: 15),
        ],
      ),
      // Move the content to the body of the Scaffold
      body: _buildHomeContent(),
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          buildProfileHeader(),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: buildActionCard(
                  title: "Upload your music",
                  bgColor: const Color(0xFFE7EEFF),
                  icon: Icons.music_note,
                  iconColor: Colors.blue,
                  onUploadPressed: () => Get.toNamed('/music_upload')

                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: buildActionCard(
                  title: "Upload your content",
                  bgColor: const Color(0xFFFFF4F2),
                  icon: Icons.videocam,
                  iconColor: Colors.orange,
                  onUploadPressed: () => Get.toNamed('/content_upload'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          buildAnalyticsSection(),
        ],
      ),
    );
  }
}