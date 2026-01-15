import 'package:echotune/modules/creator/creator_dashboard/widgets/upload_action_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/creator_dashboard_controller.dart';
import '../widgets/analytics_chart.dart';

class AdminDashboardView extends StatelessWidget {
  final controller = Get.put(AdminDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A1A1A),
        title: Text("ECHOTUNE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [Icon(Icons.settings, color: Colors.white), SizedBox(width: 10), CircleAvatar(radius: 15), SizedBox(width: 15)],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: ActionUploadCard(
                    title: "Upload your music",
                    bgColor: Color(0xFFEEF2FF),
                    icon: Icons.music_note,
                    iconColor: Colors.blue,
                    onUpload: controller.onUploadMusic
                )),
                SizedBox(width: 12),
                Expanded(child: ActionUploadCard(
                    title: "Upload your content",
                    bgColor: Color(0xFFFFF4F2),
                    icon: Icons.videocam,
                    iconColor: Colors.orange,
                    onUpload: controller.onUploadContent
                )),
              ],
            ),
            SizedBox(height: 20),
            _buildAnalyticsSection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 25, backgroundImage: AssetImage('assets/profile.png')),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome to Copyva", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text("Thamas varghese", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStat("Music Uploaded", controller.musicUploaded),
              _buildStat("Content Uploaded", controller.contentUploaded),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStat(String label, RxInt value) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.grey, fontSize: 12)),
        Obx(() => Text("${value.value}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue))),
      ],
    );
  }

  Widget _buildAnalyticsSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Statements", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("Explore", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildChartPlaceholder()),
              SizedBox(width: 12),
              Column(
                children: [
                  AnalyticsStatTile(label: "Music & Content", value: "24", valueColor: Colors.black),
                  SizedBox(height: 8),
                  AnalyticsStatTile(label: "Music", value: "14", valueColor: Colors.blue),
                  SizedBox(height: 8),
                  AnalyticsStatTile(label: "Content", value: "10", valueColor: Colors.orange),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildChartPlaceholder() {
    // You can use the 'fl_chart' package here to implement the actual line chart
    return Container(height: 150, color: Colors.grey[50], child: Center(child: Text("Line Chart Placeholder")));
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      selectedItemColor: Color(0xFFE5B25D),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Statement"),
        BottomNavigationBarItem(icon: Icon(Icons.cloud_upload), label: "Upload list"),
        BottomNavigationBarItem(icon: Icon(Icons.error_outline), label: "Complaint"),
      ],
    );
  }
}