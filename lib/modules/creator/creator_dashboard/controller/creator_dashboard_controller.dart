import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/creator_dashboard_view.dart';

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

  // Mock data for the chart spots
  final chartSpots = <FlSpot>[
    FlSpot(0, 1), FlSpot(1, 3), FlSpot(2, 2), FlSpot(3, 5),
    FlSpot(4, 3), FlSpot(5, 4), FlSpot(6, 6), FlSpot(7, 4),
    FlSpot(8, 5), FlSpot(9, 3), FlSpot(10, 4), FlSpot(11, 2),
  ].obs;

  final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'];





}
