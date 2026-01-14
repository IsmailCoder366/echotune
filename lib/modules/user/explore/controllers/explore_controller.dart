import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController exploreTabController;

  @override
  void onInit() {
    super.onInit();
    // Length 4: All, Music, Content, Artist
    exploreTabController = TabController(length: 4, vsync: this);
  }

  @override
  void onClose() {
    exploreTabController.dispose();
    super.onClose();
  }
}