import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/custom_fields.dart';

class MusicUploadController extends GetxController {
  // --- Navigation & Stepper State ---
  // 0: Info, 1: Links, 2: Pricing, 3: Source
  var currentStep = 0.obs;
  var completedSteps = <int>[].obs;

  // --- Step 1: Song Information ---
  var musicCategory = 'Song'.obs;
  var copyrightOwner = ''.obs;
  var musicLink = ''.obs;
  var coverTemplateLink = ''.obs;
  var musicName = ''.obs;
  var artistName = ''.obs;

  // --- Step 2: Song Links ---
  var spotifyLink = ''.obs;
  var youtubeLink = ''.obs;
  var gaanaLink = ''.obs;
  var amazonLink = ''.obs;
  var wynkLink = ''.obs;
  var appleMusicLink = ''.obs;

  // --- Step 3: Pricing ---
  var selectedLicense = 'Public places'.obs;
  final List<String> licenseOptions = [
    'Public places',
    'Commercial / Business purpose',
    'Metaverse',
    'Specific / Custom licences'
  ];

  /// Core logic for "Submit" or "Next" buttons
  void handleNextStep() {
    // Mark current step as complete before moving forward
    if (!completedSteps.contains(currentStep.value)) {
      completedSteps.add(currentStep.value);
    }

    // Proper sequence logic
    if (currentStep.value == 0) {
      currentStep.value = 1; // Move to Song Links
    } else if (currentStep.value == 1) {
      currentStep.value = 2; // Move to Pricing (This was the missing link)
    } else if (currentStep.value == 2) {
      // Logic for after Pricing (e.g., final submission or next step)

    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
      // Optional: Remove green status when going back to edit
      completedSteps.remove(currentStep.value);
    }
  }

  void submitFinalData() {
    // Add your API call or final summary logic here
    Get.snackbar("Success", "Music uploaded successfully!");
  }

  @override
  void onInit() {
    super.onInit();
    // Show the "Note" bottom sheet on first load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showPriceNote();
    });
  }

  void showPriceNote() {
    Get.bottomSheet(
      const PriceNoteBottomSheet(),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }
}