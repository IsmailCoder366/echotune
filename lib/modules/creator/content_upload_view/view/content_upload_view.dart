import 'package:echotune/modules/creator/content_upload_view/controller/content_upload_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../../core/constants/app_colors.dart';

class ContentUploadView extends StatelessWidget {
  const ContentUploadView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContentUploadController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Content upload", style: TextStyle(color: Colors.black)),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            onPressed: controller.showContentPriceNote,
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
        ),
      ),
    );
  }
}


Widget _buildCurrentForm(ContentUploadController controller) {
  return Obx(() {
    switch (controller.currentStep.value) {
      case 0:
        return _buildContentInformationForm(controller);
      case 1:
        return _buildContentLinkForm(controller);
      default:
        return const Center(child: Text("Next Steps Pending"));
    }
  });
}

Widget _buildContentInformationForm(ContentUploadController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("Content Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 20),

      _buildLabelledField("Copyright owner name *", "Enter name", controller.copyrightOwnerController),
      _buildLabelledField("Upload cover template *", "Enter link from a platform (Ex: Spotify, Youtube, IMusic etc)", controller.coverTemplateController),
      _buildLabelledField("Content name *", "Enter content name", controller.contentNameController),
      _buildLabelledField("Artist name *", "Enter artist name", controller.artistNameController),

      const Text("Month & year of release *", style: TextStyle(color: Colors.grey, fontSize: 14)),
      const SizedBox(height: 8),
      _buildDatePicker(controller),

      const SizedBox(height: 16),
      const Text("Language *", style: TextStyle(color: Colors.grey, fontSize: 14)),
      const SizedBox(height: 8),
      _buildLanguageDropdown(controller),
    ],
  );
}

Widget _buildLabelledField(String label, String hint, TextEditingController textController) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDatePicker(ContentUploadController controller) {
  return Obx(() => Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    child: ListTile(
      title: Text(
        controller.selectedMonthYear.value.isEmpty ? "Select month & year" : controller.selectedMonthYear.value,
        style: TextStyle(color: controller.selectedMonthYear.value.isEmpty ? Colors.grey : Colors.black, fontSize: 14),
      ),
      trailing: const Icon(Icons.calendar_today_outlined, size: 20),
      onTap: () async {
        // Add your DatePicker logic here
        controller.selectedMonthYear.value = "January 2026";
      },
    ),
  ));
}

Widget _buildLanguageDropdown(ContentUploadController controller) {
  return Obx(() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        isExpanded: true,
        hint: const Text("Select language", style: TextStyle(fontSize: 14)),
        value: controller.selectedLanguage.value.isEmpty ? null : controller.selectedLanguage.value,
        items: controller.languages.map((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
        onChanged: (newValue) => controller.selectedLanguage.value = newValue!,
      ),
    ),
  ));
}

Widget _buildBottomActions(ContentUploadController controller) {
  return Container(
    padding: const EdgeInsets.all(16),
    width: double.infinity,
    child: Row(
      children: [
        // Only show Back button if we are past the first step
        if (controller.currentStep.value > 0)
          Expanded(
            child: OutlinedButton(
              onPressed: () => controller.previousStep(),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.grey.shade100, // Light grey background like in your images
                side: BorderSide.none,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                  "Back",
                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)
              ),
            ),
          ),

        // Spacing between buttons if Back is visible
        if (controller.currentStep.value > 0) const SizedBox(width: 12),

        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () => controller.handleNextStep(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              // Show "Submit" on the very last step (Step 3: Agreement)
              controller.currentStep.value == 3 ? "Submit" : "Next",
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ),
  );
}

// --- Stepper UI ---
Widget _buildStepperHeader(ContentUploadController controller) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 20),
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
Widget _stepBubble(String num, String label, int index, ContentUploadController controller) {
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
            ? const Icon(Icons.check_circle_outline, color: Colors.green, size: 18)
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

Widget _buildContentLinkForm(ContentUploadController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
          "Song Link",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
      ),
      const SizedBox(height: 20),

      _buildLabelledField("Instagram link", "Enter link", controller.instagramController),
      _buildLabelledField("Youtube link", "Enter link", controller.youtubeController),
      _buildLabelledField("Facebook link", "Enter link", controller.facebookController),
      _buildLabelledField("Twitter link", "Enter link", controller.twitterController),
      _buildLabelledField("Linkedin link", "Enter link", controller.linkedinController),
      _buildLabelledField("Pepul link", "Enter link", controller.pepulController),
    ],
  );
}