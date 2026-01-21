// --- Navigation & Stepper State ---
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/price_note_bottom_sheet.dart';

class ContentUploadController extends GetxController {
// --- Pricing Sub-Step Logic ---
var pricingSubStep = 1.obs;
var currentStep = 0.obs;
var completedSteps = <int>[].obs; // Stores indexes of finished steps


// Form Field Controllers
  final copyrightOwnerController = TextEditingController();
  final coverTemplateController = TextEditingController();
  final contentNameController = TextEditingController();
  final artistNameController = TextEditingController();
  var selectedMonthYear = "".obs;
  var selectedLanguage = "".obs;


  // --- Step 2 Controllers (Links) ---
  final instagramController = TextEditingController();
  final youtubeController = TextEditingController();
  final facebookController = TextEditingController();
  final twitterController = TextEditingController();
  final linkedinController = TextEditingController();
  final pepulController = TextEditingController();


  final List<String> languages = ["English", "Spanish", "French", "Hindi", "Mandarin"];

/// Helper to handle green completion status
void _markStepAsComplete(int index) {
  if (!completedSteps.contains(index)) {
    completedSteps.add(index);
  }
}

/// Core logic for "Next" button with completion tracking
void handleNextStep() {
  if (currentStep.value == 0) {
    _markStepAsComplete(0); // Mark Info as Green
    currentStep.value = 1;
  }
  else if (currentStep.value == 1) {
    _markStepAsComplete(1); // Mark Links as Green
    currentStep.value = 2;
    pricingSubStep.value = 1;
  }
  else if (currentStep.value == 2) {
    // Internal Pricing Logic
    if (pricingSubStep.value == 1) {
      pricingSubStep.value = 2;
    } else if (pricingSubStep.value == 2) {
      pricingSubStep.value = 3;
    } else {
      // Only mark Pricing as Green when all sub-steps are done
      _markStepAsComplete(2);
      currentStep.value = 3;
    }
  }
}

void previousStep() {
  if (currentStep.value == 2 && pricingSubStep.value > 1) {
    pricingSubStep.value--;
  }
  else if (currentStep.value > 0) {
    currentStep.value--;
    // Remove green status when going back to edit a step
    completedSteps.remove(currentStep.value);
  }
}

@override
void onInit() {
  super.onInit();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showContentPriceNote();
  });
}

void showContentPriceNote() {
  Get.bottomSheet(
    const ContentPriceNoteBottomSheet(),
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
  );
}

@override
void onClose() {
  copyrightOwnerController.dispose();
  coverTemplateController.dispose();
  contentNameController.dispose();
  artistNameController.dispose();
  instagramController.dispose();
  youtubeController.dispose();
  facebookController.dispose();
  twitterController.dispose();
  linkedinController.dispose();
  pepulController.dispose();
  super.onClose();
}
}