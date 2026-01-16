import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/custom_fields.dart';

class MusicUploadController extends GetxController {
  // --- Navigation & Stepper State ---
  // 0: Info, 1: Links, 2: Pricing, 3: Source
  var currentStep = 0.obs;
  var completedSteps = <int>[].obs;

  // --- Pricing Sub-Step Logic ---
  // 1: License Selection (Image 1286), 2: Specific Details (Image 1287)
  var pricingSubStep = 1.obs;

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

  // --- Step 3: Pricing Selections ---
  var selectedLicense = 'Public places'.obs;
  var selectedPublicPlaceDetail = 'Background'.obs;

  final List<String> licenseOptions = [
    'Public places',
    'Commercial / Business purpose',
    'Metaverse',
    'Specific / Custom licences'
  ];

  final List<String> publicPlaceDetails = ['Background', 'Live performance'];

  // Getter to handle the "Step X/4" text based on license selection
  int get licenseSubStep {
    switch (selectedLicense.value) {
      case 'Public places': return 1;
      case 'Commercial / Business purpose': return 2;
      case 'Metaverse': return 3;
      case 'Specific / Custom licences': return 4;
      default: return 1;
    }
  }

  void updateLicense(String value) {
    selectedLicense.value = value;
  }

  /// Core logic for "Submit" or "Next" buttons
  void handleNextStep() {
    // Stage 0: Song Information
    if (currentStep.value == 0) {
      if (!completedSteps.contains(0)) completedSteps.add(0);
      currentStep.value = 1;
    }
    // Stage 1: Song Links
    else if (currentStep.value == 1) {
      if (!completedSteps.contains(1)) completedSteps.add(1);
      currentStep.value = 2; // Moves to Pricing
      pricingSubStep.value = 1; // Ensure we start at the License picker
    }
    // Stage 2: Pricing
    else if (currentStep.value == 2) {
      // If we are on the License Picker and "Public Places" is selected, move to Details
      if (pricingSubStep.value == 1 && selectedLicense.value == 'Public places') {
        pricingSubStep.value = 2;
      } else {
        // Otherwise, mark Pricing as done and move to Stage 3 (Source)
        if (!completedSteps.contains(2)) completedSteps.add(2);
        currentStep.value = 3;
      }
    }
  }

  void previousStep() {
    // If we are inside the nested Pricing Detail screen, go back to License Picker
    if (currentStep.value == 2 && pricingSubStep.value == 2) {
      pricingSubStep.value = 1;
    }
    // Otherwise, handle standard stepper back navigation
    else if (currentStep.value > 0) {
      currentStep.value--;
      completedSteps.remove(currentStep.value);
    }
  }

  void submitFinalData() {
    Get.snackbar("Success", "Music uploaded successfully!");
  }

  @override
  void onInit() {
    super.onInit();
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