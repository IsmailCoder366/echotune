import 'package:echotune/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/upload_music_controller.dart';
import '../widgets/custom_fields.dart';
import '../widgets/license_option_tile.dart';

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
      body: Obx(() => Column(
        children: [
          _buildStepperHeader(controller),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildCurrentForm(controller),
            ),
          ),
          _buildBottomActions(controller),
        ],
      )),
    );
  }

  Widget _buildCurrentForm(MusicUploadController controller) {
    switch (controller.currentStep.value) {
      case 0:
        return _buildSongInformationForm(controller);
      case 1:
        return _buildSongLinksForm(controller);
      case 2:
        return _buildPricingForm(controller);
      default:
        return const Center(child: Text("Step not implemented"));
    }
  }

  // --- Step 1: Song Information ---
  Widget _buildSongInformationForm(MusicUploadController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Song Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        const Text("Music category"),
        Row(
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
        ),
        const LabeledTextField(label: "Copyright owner name", hint: "Enter name"),
        const LabeledTextField(label: "Upload music", hint: "Enter link from platform"),
        const LabeledTextField(label: "Upload Cover Template", hint: "Enter link from platform"),
        const LabeledTextField(label: "Music Name", hint: "Enter music name"),
        const LabeledTextField(label: "Artist Name", hint: "Enter artist name"),
        const LabeledTextField(label: "Month & Year Release", hint: "Enter month or year"),
      ],
    );
  }

  // --- Step 2: Song Links ---
  Widget _buildSongLinksForm(MusicUploadController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Song Links", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        const LabeledTextField(label: "Spotify Link", hint: "Enter link"),
        const LabeledTextField(label: "Youtube Link", hint: "Enter link"),
        const LabeledTextField(label: "Gaana Link", hint: "Enter link"),
        const LabeledTextField(label: "Amazon Music Link", hint: "Enter link"),
        const LabeledTextField(label: "Wynk Music Link", hint: "Enter link"),
        const LabeledTextField(label: "Apple Music Link", hint: "Enter link"),
      ],
    );
  }

  // --- Step 3: Pricing (With Sub-Step logic for Image 1286 & 1287) ---
  Widget _buildPricingForm(MusicUploadController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Pricing", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // Counter now reflects internal pricing progress
            Text(
              "Step ${controller.pricingSubStep.value}/4",
              style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Dynamic subtitle logic
        Text(
          controller.pricingSubStep.value == 1
              ? "License for the song that you selected"
              : "License to use music in ${controller.selectedLicense.value.toLowerCase()} as",
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 20),

        // Content Switcher
        if (controller.pricingSubStep.value == 1)
          ...controller.licenseOptions.map((option) => LicenseOptionTile(
            title: option,
            groupValue: controller.selectedLicense.value,
            onChanged: (val) => controller.updateLicense(val!),
          ))
        else
          ...controller.publicPlaceDetails.map((detail) => LicenseOptionTile(
            title: detail,
            groupValue: controller.selectedPublicPlaceDetail.value,
            onChanged: (val) => controller.selectedPublicPlaceDetail.value = val!,
          )),
      ],
    );
  }

  // --- Stepper UI ---
  Widget _buildStepperHeader(MusicUploadController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _stepBubble("1", "Song information", 0, controller),
            const SizedBox(width: 12),
            _stepBubble("2", "Song links", 1, controller),
            const SizedBox(width: 12),
            _stepBubble("3", "Pricing", 2, controller),
            const SizedBox(width: 12),
            _stepBubble("4", "Agreement", 3, controller),
          ],
        ),
      ),
    );
  }

  Widget _stepBubble(String num, String label, int index, MusicUploadController controller) {
    bool isActive = controller.currentStep.value == index;
    bool isCompleted = controller.completedSteps.contains(index);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isCompleted ? const Color(0xFFE8F5E9) : (isActive ? Colors.black87 : Colors.grey.shade100),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isCompleted
              ? const Icon(Icons.check_circle, color: Colors.green, size: 18)
              : CircleAvatar(
            radius: 10,
            backgroundColor: isActive ? AppColors.primaryColor : Colors.grey,
            child: Text(num, style: TextStyle(fontSize: 10, color: isActive ? Colors.black : Colors.black26)),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
                color: isCompleted ? Colors.green : (isActive ? Colors.white : Colors.grey),
                fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(MusicUploadController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Row(
        children: [
          if (controller.currentStep.value > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () => controller.previousStep(),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.grey.shade100,
                  side: BorderSide.none,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Back", style: TextStyle(color: Colors.grey)),
              ),
            ),
          if (controller.currentStep.value > 0) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () => controller.handleNextStep(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 22),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                // Button shows "Finish" only at the very end of the main flow
                controller.currentStep.value == 3 ? "Finish" : "Next",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}