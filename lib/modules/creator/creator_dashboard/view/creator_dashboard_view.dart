import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/constants/app_colors.dart';
import '../controller/creator_dashboard_controller.dart';
// Note: Ensure these local imports exist or replace them with standard widgets
// import 'package:echotune/modules/creator/creator_dashboard/widgets/upload_action_card.dart';

class AdminDashboardView extends StatelessWidget {
  // Ensure your controller name matches your actual file
  final controller = Get.put(AdminDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text("ECHOTUNE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: const [
          Icon(Icons.settings_outlined, color: Colors.white),
          SizedBox(width: 10),
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
          SizedBox(width: 15)
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    title: "Upload your music",
                    bgColor: const Color(0xFFE7EEFF),
                    icon: Icons.music_note,
                    iconColor: Colors.blue,
                    onTap: () => controller.onUploadMusic(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionCard(
                    title: "Upload your content",
                    bgColor: const Color(0xFFFFF4F2),
                    icon: Icons.videocam,
                    iconColor: Colors.orange,
                    onTap: () => controller.onUploadContent(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildAnalyticsSection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: const ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFFE7EEFF),
              child: Icon(Icons.music_note_outlined, color: Color(0xFF769EFF)),
            ),
            title: Text('Lorem Ipsum', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Lorem ipsum dolor sit amet'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  CircleAvatar(radius: 25, backgroundImage: AssetImage('assets/images/profile.png')),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome to Copyva", style: TextStyle(fontSize: 12)),
                      Text("Thomas Varghese", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem("Music Uploaded", controller.musicUploaded, Colors.blue),
                  _buildStatItem("Content Uploaded", controller.contentUploaded, const Color(0xFFFFB894)),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, RxInt value, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        Obx(() => Text(
          "${value.value}",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
        )),
      ],
    );
  }

  Widget _buildAnalyticsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Statements", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("Explore", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              // Integration of your Line Chart
              Expanded(flex: 2, child: LineChartSample()),
              const SizedBox(width: 12),
              const Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _SmallStatTile(label: "Music & Content", value: "24", color: Colors.black),
                    _SmallStatTile(label: "Music", value: "14", color: Colors.blue),
                    _SmallStatTile(label: "Content", value: "10", color: Colors.orange),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildActionCard({required String title, required Color bgColor, required IconData icon, required Color iconColor, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      selectedItemColor: const Color(0xFFE5B25D),
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Statement"),
        BottomNavigationBarItem(icon: Icon(Icons.cloud_upload), label: "Upload list"),
        BottomNavigationBarItem(icon: Icon(Icons.error_outline), label: "Complaint"),
      ],
    );
  }
}

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
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index >= 0 && index < controller.months.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        controller.months[index],
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    );
                  }
                  return const Text('');
                },
                reservedSize: 30,
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

// --- Helper UI Components ---
class _SmallStatTile extends StatelessWidget {
  final String label, value;
  final Color color;
  const _SmallStatTile({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}