import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeroIndicatorController extends GetxController {
  // Page controller to detect and manage horizontal scrolling
  final PageController pageController = PageController();

  // Observable index for the current page
  var currentIndex = 0.obs;

  // Requirement: length of 4
  final int totalSlides = 4;

  // Called when the user manually swipes
  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  // Called when the user taps an indicator dot
  void jumpToPage(int index) {
    currentIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}