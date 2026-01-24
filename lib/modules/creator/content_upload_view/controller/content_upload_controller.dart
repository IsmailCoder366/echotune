import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentUploadController extends GetxController {
  // --- Navigation & Stepper State ---
  var currentStep = 0.obs;
  var completedSteps = <int>[].obs;
  var permissionSubStep = 1.obs; // Tracks the 1/4 progress in Step 3

  // --- Step 1: Information Controllers ---
  final copyrightOwnerController = TextEditingController();
  final coverTemplateController = TextEditingController();
  final contentNameController = TextEditingController();
  final artistNameController = TextEditingController();
  var selectedMonthYear = "".obs;
  var selectedLanguage = "".obs;
  final List<String> languages = ["English", "Spanish", "French", "Hindi", "Mandarin"];

  // --- Step 2: Link Controllers ---
  final instagramController = TextEditingController();
  final youtubeController = TextEditingController();
  final facebookController = TextEditingController();
  final twitterController = TextEditingController();
  final linkedinController = TextEditingController();
  final pepulController = TextEditingController();

  // --- Step 3: Permission Data ---
  var selectedPermissionLicense = 'Commercial / Business purpose'.obs;
  var selectedPermissionPlatform = 'Youtube'.obs;
  var selectedSubscriberRange = '0 to 50,000 subscribers'.obs;

  final List<String> permissionOptions = [
    'Commercial / Business purpose',
    'Specific / Custom licences',
    'Metaverse',
    'Specific / Custom licences'
  ];

  final List<String> permissionPlatforms = [
    'Youtube', 'Instagram', 'Facebook', 'Set a discussion with Copyva team'
  ];

  final List<String> subscriberRanges = [
    '0 to 50,000 subscribers',
    '50,000 to 5,00,000 subscribers',
    '5,00,000 to 20,00,000 subscribers',
    '20 lakhs (2 million) to 1 crore (10 million) subcribers',
    'More than 1 crore (10 million) subcribers',
  ];


  // --- Step 4: Agreement Section ---
  final annextureController = TextEditingController(
      text: "The description of Work of the owner\nPlayed by --------------------------\nDescription of the Timeline that cannot be used by user.(i.e,sections of the video that are not owned by the owner)"
  );

  final agreementTermsController = TextEditingController(
      text: "THIS TERMS OF SERVICE AGREEMENT (“Agreement”) is made between the OWNER (which term shall mean an author as defined in the Copyright Act 1957), and any person or Association of persons or Partnership firm or Company or such other legal entity who complete the registration and payment process to use the copyrighted work of the Owner (Herein after called as “User”) and both the Owner and the User are collectively referred as “Parties.”\n\nThe copyrighted works of the owner will collectively be referred to as “Work” which..."
  );
  // --- Step 3: Permission Sub-step 4 Details ---
  final permissionHeadingController = TextEditingController();
  final expiryController = TextEditingController();
  final nonExpiryController = TextEditingController();

  // --- Navigation Logic ---
  void handleNextStep() {
    if (currentStep.value == 0) {
      _markStepAsComplete(0);
      currentStep.value = 1;
    } else if (currentStep.value == 1) {
      _markStepAsComplete(1);
      currentStep.value = 2;
      permissionSubStep.value = 1;
    } else if (currentStep.value == 2) {
      if (permissionSubStep.value < 4) {
        permissionSubStep.value++;
      } else {
        _markStepAsComplete(2);
        currentStep.value = 3; // Move to Agreement
      }
    } else if (currentStep.value == 3) {
      Get.snackbar("Success", "Content Submitted for Review");
      Get.toNamed('/creatorMainScreen');
    }
  }

  void previousStep() {
    if (currentStep.value == 2 && permissionSubStep.value > 1) {
      permissionSubStep.value--;
    } else if (currentStep.value > 0) {
      currentStep.value--;
      completedSteps.remove(currentStep.value);
    }
  }

  void _markStepAsComplete(int index) {
    if (!completedSteps.contains(index)) completedSteps.add(index);
  }

  void showContentPriceNote() {
    // Logic for top-right lightbulb icon
    Get.snackbar("Tip", "Set your pricing based on market standards.");
  }

  void addCustomOption() => Get.snackbar("Action", "Add option dialog");
  void addPermissionDetailOption() => Get.snackbar("Action", "Add list item");
  void handleEditPrice(String range) => Get.snackbar("Edit", "Price for $range");

  @override
  void onClose() {
    // Dispose all controllers
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
    permissionHeadingController.dispose();
    expiryController.dispose();
    nonExpiryController.dispose();
    annextureController.dispose();
    agreementTermsController.dispose();
    super.onClose();
  }
}