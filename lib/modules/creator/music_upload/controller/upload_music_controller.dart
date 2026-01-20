import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/custom_fields.dart';

class MusicUploadController extends GetxController {
  // --- Navigation & Stepper State ---
  var currentStep = 0.obs;
  var completedSteps = <int>[].obs; // Stores indexes of finished steps

  // --- Pricing Sub-Step Logic ---
  var pricingSubStep = 1.obs;

  // Selections
  var selectedLicense = 'Public places'.obs;
  var selectedUsage = 'Background'.obs;
  var selectedPlaceCategory = 'Clubs, pubs & night clubs'.obs;

  // --- Step 1: Song Information Data ---
  var musicCategory = 'Song'.obs;
  var copyrightOwner = ''.obs;
  var musicLink = ''.obs;
  var coverTemplateLink = ''.obs;
  var musicName = ''.obs;
  var artistName = ''.obs;

  // --- Step 2: Song Links Data ---
  var spotifyLink = ''.obs;
  var youtubeLink = ''.obs;
  var gaanaLink = ''.obs;
  var amazonLink = ''.obs;
  var wynkLink = ''.obs;
  var appleMusicLink = ''.obs;

  final List<String> licenseOptions = [
    'Public places',
    'Commercial / Business purpose',
    'Metaverse',
    'Specific / Custom licences'
  ];
  final List<String> publicPlaceDetails = ['Background', 'Live performance'];
  final List<String> placeCategories = [
    'Clubs, pubs & night clubs',
    'Restaurants, dining rooms, bars, lounges, coffee houses, etc',
    'Multiplex & shopping center, arcades, IT parks, etc',
    'Lodges, guest houses, vacation homes, resorts, etc',
    'Banquet halls & auditoriums, sports, service oriented premises, waiting transport services',
  ];

  // Logic for "Step X/4" text
  int get licenseSubStep => pricingSubStep.value;

  void updateLicense(String value) {
    selectedLicense.value = value;
  }

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

  // Text for the Agreement step (can be fetched from API)
  final String annextureText = "The description of Work of the owner Played by ------------------------ Description of the Timeline that cannot be used by user.(i.e,sections of the video that are not owned by the owner)";

  final String termsOfServiceText = """THIS TERMS OF SERVICE AGREEMENT (“Agreement”) is made between the OWNER (which term shall mean an author as defined in the Copyright Act 1957), and any person or Association of persons or Partnership firm or Company or such other legal entity who complete the registration and payment process to use the copyrighted work of the Owner (Herein after called as “User”) and both the Owner and the User are collectively referred as “Parties.”

The copyrighted works of the owner will collectively be referred to as “Work” which...""";

  void submitFinalAgreement() {
    // Final logic before closing the upload flow
    _markStepAsComplete(3);
    Get.defaultDialog(
      title: "Success",
      middleText: "Your music has been uploaded and agreement signed.",
      onConfirm: () => Get.back(),
    );
  }
}