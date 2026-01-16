import 'package:echotune/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/upload_music_controller.dart';
import '../widgets/custom_fields.dart';

class MusicUploadView extends StatelessWidget {
  const MusicUploadView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MusicUploadController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Music upload", style: TextStyle(color: Colors.black)),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            onPressed: controller.showPriceNote,
            icon: const Icon(Icons.tips_and_updates_outlined, color: Colors.black),
          )
        ],
      ),
      body: Column(
        children: [
          // Stepper Header
          _buildStepperHeader(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Song Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  const Text("Music category"),
                  Obx(() => Row(
                    children: [
                      Radio(
                        activeColor: Colors.black,
                        value: 'Song',
                        groupValue: controller.musicCategory.value,
                        onChanged: (val) => controller.musicCategory.value = val!,
                      ),
                      const Text("Song"),
                      Radio(
                        activeColor: Colors.black,
                        value: 'Instrumental',
                        groupValue: controller.musicCategory.value,
                        onChanged: (val) => controller.musicCategory.value = val!,
                      ),
                      const Text("Instrumental"),
                    ],
                  )),
                  const LabeledTextField(label: "Copyright owner name", hint: "Enter name"),
                  const LabeledTextField(label: "Upload music", hint: "Enter link from platform(eg: spotify, youtube, imusic etc)"),
                  const LabeledTextField(label: "Upload Cover Template", hint: "Enter link from platform(eg: spotify, youtube, imusic etc)"),
                  const LabeledTextField(label: "Music Name", hint: "Enter music name"),
                  const LabeledTextField(label: "Artist Name", hint: "Enter music name"),
                  const LabeledTextField(label: "Month & Year Release", hint: "Enter month or year"),
                ],
              ),
            ),
          ),

          // Submit Button
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 22),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Submit", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepperHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _stepBubble("1", "Song information", true),
          _stepBubble("2", "Song link", false),
          _stepBubble("3", "Source", false),
        ],
      ),
    );
  }

  Widget _stepBubble(String num, String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.black87 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 10,
            backgroundColor: isActive ? AppColors.primaryColor : Colors.grey,
            child: Text(num, style:  TextStyle(fontSize: 10, color: isActive ? Colors.black : Colors.black26)),
          ),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: isActive ? Colors.white : Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}