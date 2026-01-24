import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/creator_dashboard_controller.dart';

class LineChartSample extends StatelessWidget {
  // We use find because the controller is already initialized in the Dashboard
  final AdminDashboardController controller = Get.find();

  LineChartSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>  Column(
        children: [
          // 1. THE CHART AREA
          AspectRatio(
            aspectRatio: 2.0, // Made it a bit slimmer to fit the buttons below
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) => const Color(0xFF0D121C),
                    getTooltipItems: (List<LineBarSpot> touchedSpots) {
                      return touchedSpots.map((barSpot) {
                        return LineTooltipItem(
                          'Music & content\n',
                          const TextStyle(color: Colors.white, fontSize: 10),
                          children: [
                            TextSpan(
                              text: '${barSpot.y.toInt()}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      }).toList();
                    },
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: false, // Image shows very clean background
                  drawVerticalLine: true,
                  getDrawingVerticalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.1),
                    strokeWidth: 1,
                    dashArray: [5, 5],
                  ),
                ),
                // We hide titles here because we are building CUSTOM titles below
                // to match the spacing and buttons in your image.
                titlesData: const FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: controller.chartSpots,
                    isCurved: true,
                    curveSmoothness: 0.35,
                    color: const Color(0xFF1A1C1E),
                    barWidth: 2,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) =>
                          FlDotCirclePainter(
                            radius: 3,
                            color: Colors.black,
                            strokeWidth: 1,
                            strokeColor: Colors.white,
                          ),
                    ),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // 2. THE NAVIGATION ROW (The part you were missing!)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left Button
              IconButton(
                onPressed: () => controller.previousMonths(),
                icon: const Icon(Icons.arrow_circle_left_outlined, color: Colors.grey),
              ),

              // The Months with Spacing
              ...List.generate(controller.months.length, (index) {
                return Text(
                  controller.months[index],
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                );
              }),

              // Right Button
              IconButton(
                onPressed: () => controller.nextMonths(),
                icon: const Icon(Icons.arrow_circle_right_outlined, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}