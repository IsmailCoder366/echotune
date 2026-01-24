import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class AdminDashboardController extends GetxController {
  // 1. Statistics (The numbers at the top)
  var musicUploaded = 0.obs;
  var contentUploaded = 0.obs;

  // 2. Dropdown selections
  var selectedStatementType = 'All'.obs;
  var selectedYear = '2024'.obs;

  // 3. Totals (Right side of the chart)
  var musicContentTotal = 24.obs;
  var musicTotal = 14.obs;
  var contentTotal = 10.obs;

  // 4. THE MAGIC: Sliding Window Logic
  // This tracks which month we start showing (0 = Jan)
  var startIndex = 0.obs;

  // Full data for the whole year
  final List<String> allMonths = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  // Full data points for the whole year
  final List<FlSpot> allSpots = const [
    FlSpot(0, 1), FlSpot(1, 3), FlSpot(2, 2), FlSpot(3, 5),
    FlSpot(4, 3), FlSpot(5, 4), FlSpot(6, 6), FlSpot(7, 4),
    FlSpot(8, 5), FlSpot(9, 3), FlSpot(10, 4), FlSpot(11, 2),
  ];

  // 5. GETTERS: These give the View only the "Slice" it needs
  // This gives the 6 months to show on the screen
  List<String> get months => allMonths.sublist(startIndex.value, startIndex.value + 6);

  // This gives the 6 dots to show on the chart
  List<FlSpot> get chartSpots {
    return allSpots.sublist(startIndex.value, startIndex.value + 6).asMap().entries.map((e) {
      // We reset the X coordinate to 0, 1, 2, 3, 4, 5 so they align with the 6 labels
      return FlSpot(e.key.toDouble(), e.value.y);
    }).toList();
  }

  // 6. FUNCTIONS: The buttons call these
  void nextMonths() {
    // Only go forward if we aren't at the end (Dec)
    if (startIndex.value < allMonths.length - 6) {
      startIndex.value++;
    }
  }

  void previousMonths() {
    // Only go back if we aren't at the beginning (Jan)
    if (startIndex.value > 0) {
      startIndex.value--;
    }
  }

  // Navigation
  void onUploadMusic() => Get.toNamed('/upload-music');
  void onUploadContent() => Get.toNamed('/upload-content');
}