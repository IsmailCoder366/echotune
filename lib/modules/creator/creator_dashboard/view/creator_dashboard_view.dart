import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/creator_dashboard_controller.dart';
import '../widgets/build_action_card.dart';
import '../widgets/build_profile_header.dart';
import 'bottom_navbar.dart';
import 'build_analytic_section.dart';



class AdminDashboardView extends StatelessWidget {
  // Ensure your controller name matches your actual file
  final controller = Get.put(AdminDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text("ECHOTUNE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: const [
          Icon(Icons.settings_outlined, color: Colors.white),
          SizedBox(width: 10),
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
          SizedBox(width: 15)
        ],
      ),
      body: SingleChildScrollView(
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
                    onTap: () => controller.onUploadMusic(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: buildActionCard(
                    title: "Upload your content",
                    bgColor: const Color(0xFFFFF4F2),
                    icon: Icons.videocam,
                    iconColor: Colors.orange,
                    onTap: () => controller.onUploadContent(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            buildAnalyticsSection(),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNav(),
    );
  }










}



