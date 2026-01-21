import 'package:get/get.dart';

class CreatorMainController extends GetxController {
  // Observable for the current bottom nav index
  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}