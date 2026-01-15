import 'package:get/get.dart';

class AdminDashboardController extends GetxController {
  // Statistics observables
  var musicUploaded = 0.obs;
  var contentUploaded = 0.obs;

  // Analytics data
  var selectedStatementType = 'All'.obs;
  var selectedYear = '2024'.obs;

  // Graph Data
  var musicContentTotal = 24.obs;
  var musicTotal = 14.obs;
  var contentTotal = 10.obs;

  void onUploadMusic() => Get.toNamed('/upload-music');
  void onUploadContent() => Get.toNamed('/upload-content');
}