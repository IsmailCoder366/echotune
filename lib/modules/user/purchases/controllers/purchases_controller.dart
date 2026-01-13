import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PurchasesController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  // Observable lists for the different tab bodies
  var purchaseItems = <String>["Track 1", "Track 2", "Track 3", "Track 4", "Track 5"].obs;
  var favoriteItems = <String>["Lorem Ibsum Dolor Sit", "Fav Track 2"].obs;

  @override
  void onInit() {
    super.onInit();
    // length 3: Purchases, Favourites, User Info
    tabController = TabController(length: 3, vsync: this);
  }

  // Method to jump to a specific tab index
  void jumpToTab(int index) {
    tabController.animateTo(index);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}