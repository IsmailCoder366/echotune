import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_fields.dart';

class MusicUploadController extends GetxController {
  // Observable for current step
  var currentStep = 0.obs;

  // Form Fields (Observables)
  var musicCategory = 'Song'.obs;
  var copyrightOwner = ''.obs;
  var musicLink = ''.obs;
  var coverTemplateLink = ''.obs;
  var musicName = ''.obs;
  var artistName = ''.obs;

  void nextStep() {
    if (currentStep.value < 2) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Show the bottom sheet automatically or via a trigger
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