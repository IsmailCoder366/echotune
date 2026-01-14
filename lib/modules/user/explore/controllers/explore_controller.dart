import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController exploreTabController;

  // Observable to track which track is currently playing
  var isPlayerVisible = false.obs;
  var currentTrackTitle = "".obs;
  var currentArtist = "".obs;

  // Function called when a user clicks a music/content tile
  void playTrack(String title, String artist) {
    currentTrackTitle.value = title;
    currentArtist.value = artist;
    isPlayerVisible.value = true; // Show the overlay
  }

  void closePlayer() {
    isPlayerVisible.value = false;
  }

  // Mock artist data
  final List<Map<String, String>> artistList = List.generate(10, (index) => {
    "name": "Artist Name ${index + 1}",
    "image": "assets/images/artist_placeholder.png",
  });

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