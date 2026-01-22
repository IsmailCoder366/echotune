import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/content_upload_controller.dart';

class ContentUploadView extends StatelessWidget {
  const ContentUploadView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContentUploadController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Upload Content",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            onPressed: controller.showContentPriceNote,
            icon: const Icon(
              Icons.tips_and_updates_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Obx(
        () => Column(
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

  // --- Step Switcher ---
  Widget _buildCurrentForm(ContentUploadController controller) {
    switch (controller.currentStep.value) {
      case 0:
        return _buildInformationForm(controller);
      case 1:
        return _buildLinksForm(controller);
      case 2:
        return _buildPermissionForm(controller);
      case 3:
        return _buildAgreementForm(controller);
      default:
        return Container();
    }
  }

  // --- STEP 1 UI ---
  Widget _buildInformationForm(ContentUploadController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Content Information",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        _buildLabelledField(
          "Copyright owner name *",
          "Enter name",
          controller.copyrightOwnerController,
        ),
        _buildLabelledField(
          "Upload cover template *",
          "Enter link from a platform (Ex: Spotify, Youtube, IMusic etc)",
          controller.coverTemplateController,
        ),
        _buildLabelledField(
          "Content name *",
          "Enter content name",
          controller.contentNameController,
        ),
        _buildLabelledField(
          "Artist name *",
          "Enter artist name",
          controller.artistNameController,
        ),
        const Text(
          "Month & year of release *",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        _buildDatePicker(controller),
        const SizedBox(height: 16),
        const Text(
          "Language *",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        _buildLanguageDropdown(controller),
      ],
    );
  }

  // --- STEP 2 UI ---
  Widget _buildLinksForm(ContentUploadController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Song Link",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        _buildLabelledField(
          "Instagram link",
          "Enter link",
          controller.instagramController,
        ),
        _buildLabelledField(
          "Youtube link",
          "Enter link",
          controller.youtubeController,
        ),
        _buildLabelledField(
          "Facebook link",
          "Enter link",
          controller.facebookController,
        ),
        _buildLabelledField(
          "Twitter link",
          "Enter link",
          controller.twitterController,
        ),
        _buildLabelledField(
          "Linkedin link",
          "Enter link",
          controller.linkedinController,
        ),
        _buildLabelledField(
          "Pepul link",
          "Enter link",
          controller.pepulController,
        ),
      ],
    );
  }

  // --- STEP 3 UI (Dynamic Sub-steps) ---
  Widget _buildPermissionForm(ContentUploadController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Permission to Upload",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "Step ${controller.permissionSubStep.value}/4",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          _getPermissionHeader(controller),
          style: const TextStyle(fontSize: 15, color: Colors.black87),
        ),
        const SizedBox(height: 20),
        if (controller.permissionSubStep.value == 1)
          ...controller.permissionOptions.map(
            (opt) =>
                _buildSelectionTile(opt, controller.selectedPermissionLicense),
          ),
        if (controller.permissionSubStep.value == 2) _buildSubStep2(controller),
        if (controller.permissionSubStep.value == 3) _buildSubStep3(controller),
        if (controller.permissionSubStep.value == 4) _buildSubStep4(controller),
      ],
    );
  }

  // --- STEP 4: Agreement UI ---
  Widget _buildAgreementForm(ContentUploadController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Agreement",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        // Annexture Section
        const Text(
          "Annexture",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 8),
        _buildAgreementTextContainer(controller.annextureController),

        const SizedBox(height: 24),

        // Agreement Terms Section
        const Text(
          "Agreement",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 8),
        _buildAgreementTextContainer(
          controller.agreementTermsController,
          isLarge: true,
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  // Sub-step 2: Platform selection
  Widget _buildSubStep2(ContentUploadController controller) {
    return Column(
      children: [
        ...controller.permissionPlatforms.map(
          (p) => _buildSelectionTile(p, controller.selectedPermissionPlatform),
        ),
        const SizedBox(height: 12),
        _buildAddOptionButton(controller.addCustomOption),
      ],
    );
  }

  // Sub-step 3: Subscriber selection with edit
  Widget _buildSubStep3(ContentUploadController controller) {
    return Column(
      children: controller.subscriberRanges
          .map(
            (range) => _buildSelectionTile(
              range,
              controller.selectedSubscriberRange,
              showEdit: true,
              onEdit: () => controller.handleEditPrice(range),
            ),
          )
          .toList(),
    );
  }

  // Sub-step 4: Final Details
  Widget _buildSubStep4(ContentUploadController controller) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("List 1", style: TextStyle(fontWeight: FontWeight.bold)),
          _buildLabelledField(
            "Add heading",
            "Enter your heading",
            controller.permissionHeadingController,
          ),
          _buildDescriptionField(
            "Expiry",
            "One time usage...",
            controller.expiryController,
          ),
          const SizedBox(height: 16),
          _buildDescriptionField(
            "Non Expiry",
            "Multiple usage...",
            controller.nonExpiryController,
          ),
          const SizedBox(height: 16),
          _buildAddOptionButton(controller.addPermissionDetailOption),
        ],
      ),
    );
  }

  // --- REUSABLE UI HELPERS ---

  Widget _buildSelectionTile(
    String title,
    RxString groupValue, {
    bool showEdit = false,
    VoidCallback? onEdit,
  }) {
    return Obx(() {
      bool isSelected = groupValue.value == title;
      return GestureDetector(
        onTap: () => groupValue.value = title,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.black : Colors.grey.shade300,
              width: isSelected ? 1.5 : 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: isSelected ? Colors.black : Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(title, style: const TextStyle(fontSize: 14)),
              ),
              if (showEdit)
                IconButton(
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: Colors.blue,
                    size: 20,
                  ),
                  onPressed: onEdit,
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildLabelledField(
    String label,
    String hint,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDescriptionField(
    String label,
    String desc,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget _buildAddOptionButton(VoidCallback onTap) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        side: const BorderSide(color: Colors.black54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Text(
        "+ Add an option if needed",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  String _getPermissionHeader(ContentUploadController controller) {
    if (controller.permissionSubStep.value == 1)
      return "Permission to remix/ combine...";
    if (controller.permissionSubStep.value == 2)
      return controller.selectedPermissionLicense.value;
    if (controller.permissionSubStep.value == 3)
      return controller.selectedPermissionPlatform.value;
    return "License to use ${controller.selectedPermissionPlatform.value} - ${controller.selectedSubscriberRange.value}";
  }

  Widget _buildStepperHeader(ContentUploadController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _stepBubble("1", "Content information", 0, controller),
            const SizedBox(width: 12),
            _stepBubble("2", "Content link", 1, controller),
            const SizedBox(width: 12),
            _stepBubble("3", "Permission to upload", 2, controller),
            const SizedBox(width: 12),
            _stepBubble("4", "Agreement", 3, controller),
          ],
        ),
      ),
    );
  }

  Widget _stepBubble(
    String num,
    String label,
    int index,
    ContentUploadController controller,
  ) {
    bool isActive = controller.currentStep.value == index;
    bool isCompleted = controller.completedSteps.contains(index);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isCompleted
            ? const Color(0xFFE8F5E9)
            : (isActive ? Colors.black : Colors.grey.shade100),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          if (isCompleted)
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 18,
            )
          else
            CircleAvatar(
              radius: 10,
              backgroundColor: isActive ? Colors.orange : Colors.grey,
              child: Text(
                num,
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: isCompleted
                  ? Colors.green
                  : (isActive ? Colors.white : Colors.grey),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(ContentUploadController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          if (controller.currentStep.value > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: controller.previousStep,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.grey.shade100,
                  side: BorderSide.none,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: const Text("Back", style: TextStyle(color: Colors.grey)),
              ),
            ),
          if (controller.currentStep.value > 0) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: controller.handleNextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              child: Text(
                controller.currentStep.value == 3 ? "Submit" : "Next",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker(ContentUploadController controller) {
    return GestureDetector(
      onTap: () => controller.selectedMonthYear.value = "Jan 2026",
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Text(
                controller.selectedMonthYear.value.isEmpty
                    ? "Select month & year"
                    : controller.selectedMonthYear.value,
              ),
            ),
            const Icon(Icons.calendar_today_outlined, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown(ContentUploadController controller) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: Obx(
          () => DropdownButton<String>(
            isExpanded: true,
            value: controller.selectedLanguage.value.isEmpty
                ? null
                : controller.selectedLanguage.value,
            items: controller.languages
                .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                .toList(),
            onChanged: (v) => controller.selectedLanguage.value = v!,
          ),
        ),
      ),
    );
  }

  // Reusable helper for Agreement text boxes
  Widget _buildAgreementTextContainer(
    TextEditingController textController, {
    bool isLarge = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        controller: textController,
        maxLines: isLarge ? 12 : 5,
        readOnly: true,
        // Typically these terms are view-only
        style: const TextStyle(
          fontSize: 13,
          color: Colors.black87,
          height: 1.4,
        ),
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
