import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/creator_dashboard_controller.dart';

class LineChartSample extends StatelessWidget {
  final AdminDashboardController controller = Get.find();

  LineChartSample({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7, // Adjusted to match the photo's wider look
      child: LineChart(
        LineChartData(
          // 1. Tooltip Customization (The dark box in your photo)
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
          // 2. Grid Styling (Dotted lines)
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: true,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.grey.withOpacity(0.1),
              strokeWidth: 1,
              dashArray: [5, 5],
            ),
            getDrawingVerticalLine: (value) => FlLine(
              color: Colors.grey.withOpacity(0.1),
              strokeWidth: 1,
              dashArray: [5, 5],
            ),
          ),
          // 3. Titles (Months at the bottom)
          titlesData: FlTitlesData(
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                // Forces the chart to provide space for every single index
                interval: 1,
                reservedSize: 32,
                getTitlesWidget: (double value, TitleMeta meta) {
                  if (value % 1 != 0) return const SizedBox();

                  int index = value.toInt();

                  if (index >= 0 && index < controller.months.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: 42, // ✅ SPACE BETWEEN MONTHS
                        child: Text(
                          controller.months[index],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },

              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          // 4. The Line Curve
          lineBarsData: [
            LineChartBarData(
              spots: controller.chartSpots,
              isCurved: true,
              curveSmoothness: 0.35,
              color: const Color(0xFF1A1C1E), // Dark line color from photo
              barWidth: 2,
              isStrokeCapRound: true,
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
              belowBarData: BarAreaData(
                show: true,
                color: Colors.grey.withOpacity(0.05),
              ),
            ),
          ],
        ),
      ),
    );
  }
}