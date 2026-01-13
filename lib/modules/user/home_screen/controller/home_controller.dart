import 'package:get/get.dart';

import '../models/music_model.dart';


class HomeController extends GetxController {
  // Observable variables
  var selectedTab = 0.obs; // 0: Music, 1: Content, 2: Artist
  var musicList = <MusicModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMusicData();
  }

  void fetchMusicData() {
    // Mocking data for the grid
    var items = List.generate(4, (index) => MusicModel(
      title: "Lorem ipsum dolor",
      albumName: "Top Album",
      imageUrl: "https://via.placeholder.com/150",
      trackCount: 15,
    ));
    musicList.assignAll(items);
  }

  void changeTab(int index) => selectedTab.value = index;
}