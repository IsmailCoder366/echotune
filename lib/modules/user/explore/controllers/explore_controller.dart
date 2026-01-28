import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController exploreTabController;

  final List<Map<String, String>> artistList = List.generate(10, (index) => {
    "name": "Artist Name ${index + 1}",
    "image": "assets/images/artist_placeholder.png",
  });

  @override
  void onInit() {
    super.onInit();
    exploreTabController = TabController(length: 4, vsync: this);
  }

  @override
  void onClose() {
    exploreTabController.dispose();
    super.onClose();
  }
}