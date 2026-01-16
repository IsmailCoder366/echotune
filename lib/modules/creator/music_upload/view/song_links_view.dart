import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/upload_music_controller.dart';
import '../widgets/custom_fields.dart';
import '../widgets/music_stepper_header.dart';

class SongLinksView extends StatelessWidget {
  const SongLinksView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MusicUploadController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Music upload", style: TextStyle(color: Colors.black)),
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Get.back()),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          MusicStepperHeader(),
          Expanded(
            child: Obx(() {
              // Toggle between screens based on currentStep
              if (controller.currentStep.value == 0) {
                return _buildSongInformationForm(controller);
              } else {
                return _buildSongLinksForm(controller);
              }
            }),
          ),
          _buildBottomButton(controller),
        ],
      ),
    );
  }

  Widget _buildSongLinksForm(MusicUploadController controller) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Song Links", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          LabeledTextField(label: "Spotify Link", hint: "Enter link"),
          LabeledTextField(label: "Youtube Link", hint: "Enter link"),
          LabeledTextField(label: "Gaana Link", hint: "Enter link"),
          LabeledTextField(label: "Amazon Music Link", hint: "Enter link"),
          LabeledTextField(label: "Wynk Music Link", hint: "Enter link"),
          LabeledTextField(label: "Apple Music Link", hint: "Enter link"),
        ],
      ),
    );
  }

  Widget _buildBottomButton(MusicUploadController controller) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
          onPressed: () {

          },
          child: Obx(() => Text(
            controller.currentStep.value == 0 ? "Submit" : "Finish",
            style: const TextStyle(color: Colors.white),
          )),
        ),
      ),
    );
  }

  // Placeholder for the first form content
  Widget _buildSongInformationForm(MusicUploadController controller) => const Center(child: Text("Song Info Form Content"));
}