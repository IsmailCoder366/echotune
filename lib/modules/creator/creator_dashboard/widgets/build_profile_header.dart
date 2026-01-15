import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../controller/creator_dashboard_controller.dart';

Widget buildProfileHeader() {
  final controller = Get.put(AdminDashboardController());

  return Column(
    children: [
      Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: const ListTile(
          leading: CircleAvatar(
            backgroundColor: Color(0xFFE7EEFF),
            child: Icon(Icons.music_note_outlined, color: Color(0xFF769EFF)),
          ),
          title: Text('Lorem Ipsum', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('Lorem ipsum dolor sit amet'),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                CircleAvatar(radius: 25, backgroundImage: AssetImage('assets/images/profile.png')),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome to Copyva", style: TextStyle(fontSize: 12)),
                    Text("Thomas Varghese", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildStatItem("Music Uploaded", controller.musicUploaded, Colors.blue),
                buildStatItem("Content Uploaded", controller.contentUploaded, const Color(0xFFFFB894)),
              ],
            )
          ],
        ),
      ),
    ],
  );
}

Widget buildStatItem(String label, RxInt value, Color textColor) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      Obx(() => Text(
        "${value.value}",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
      )),
    ],
  );
}