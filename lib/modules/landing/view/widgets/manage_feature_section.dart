import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ManagementFeatureSection extends StatefulWidget {
  const ManagementFeatureSection({super.key});

  @override
  State<ManagementFeatureSection> createState() => _ManagementFeatureSectionState();
}

class _ManagementFeatureSectionState extends State<ManagementFeatureSection> {
  // Logic to track which accordion is open
  int _activeStep = 0;

  final List<Map<String, String>> _featureData = [
    {
      "title": "Feature 1",
      "desc": "Lorem ipsum dolor sit amet consectetur. Suspendisse nulla ac tellus dui non eu elit eget.",
    },
    {
      "title": "Feature 2",
      "desc": "Manage your content distribution and track performance metrics across all regions.",
    },
    {
      "title": "Feature 3",
      "desc": "Access advanced statements and financial reports for your music and content.",
    },
    {
      "title": "Feature 4",
      "desc": "Collaborate with artists and creators with built-in management tools.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF111111), // Deep dark theme
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
      child: Column(
        children: [
          // 1. HEADER SECTION
          const Text(
            "Manage All Your Music/Content\nat One Place",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Lorem ipsum dolor sit amet consectetur.\nVestibulum arcu egestas duis amet non eget.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 40),

          // 2. DYNAMIC ACCORDION LIST
          Column(
            children: List.generate(_featureData.length, (index) {
              return _buildExpandableFeature(
                index: index,
                title: _featureData[index]['title']!,
                description: _featureData[index]['desc']!,
                isActive: _activeStep == index,
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableFeature({
    required int index,
    required String title,
    required String description,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () => setState(() => _activeStep = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1A1A1A) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // STEP INDICATOR (The orange line at the top of the card)
            if (isActive)
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(height: 5, color: AppColors.primaryColor,),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(height: 5, color: Colors.white),
                  ),
                ],
              ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Row
                  Row(
                    children: [
                      const Icon(Icons.description_outlined, color: Colors.white, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  // ANIMATED BODY (Shows only when active)
                  if (isActive) ...[
                    const SizedBox(height: 12),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // GET STARTED BUTTON
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              "Get Started",
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, color: AppColors.primaryColor, size: 18),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // FUNCTIONAL DASHBOARD PREVIEW (The widget we built earlier)
                    const DashboardPreview(),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class DashboardPreview extends StatelessWidget {
  const DashboardPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // 1. TOP ACTION CARDS (Blue & Orange)
          Row(
            children: [
              _buildUploadCard(
                title: "Upload Your Music",
                subtitle: "Lorem ipsum dolor sit amet consectetur.",
                icon: Icons.music_note,
                color: const Color(0xFFEEF2FF), // Light blue
                iconColor: Colors.blue,
              ),
              const SizedBox(width: 12),
              _buildUploadCard(
                title: "Upload Your Content",
                subtitle: "Lorem ipsum dolor sit amet consectetur.",
                icon: Icons.videocam_outlined,
                color: const Color(0xFFFFF7ED), // Light orange
                iconColor: Colors.orange,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 2. STATEMENTS HEADER WITH DROPDOWNS
          Row(
            children: [
              const Text(
                "Statements",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),

              _buildFilterDropdown("All"),
              const SizedBox(width: 8),
              _buildFilterDropdown("2024"),
              const SizedBox(width: 8),
              const Text("Explore", style: TextStyle(fontSize: 10, color: Colors.blue)),
            ],
          ),
          const SizedBox(height: 20),

          // 3. GRAPH AND STATS SECTION
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Placeholder for the Line Chart
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 120,
                  child: CustomPaint(
                    painter: SimpleLineChartPainter(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Side Statistics
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _buildStatItem("Music & content", "24", Colors.black),
                    _buildStatItem("Music", "14", Colors.blue),
                    _buildStatItem("Content", "10", Colors.orange),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Sub-Widgets for Dashboard ---

  Widget _buildUploadCard({required String title, required String subtitle, required IconData icon, required Color color, required Color iconColor}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
            Text(subtitle, style: const TextStyle(fontSize: 8, color: Colors.grey)),
            const SizedBox(height: 10),
            Container(
              width: 84,
              height: 19,

              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12)),
              child: const Center(child: Text("Upload", style: TextStyle(color: Colors.white, fontSize: 8))),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDropdown(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontSize: 10)),
          const Icon(Icons.arrow_drop_down, size: 14),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Text(label, style: const TextStyle(fontSize: 7, color: Colors.grey)),
            Text(value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}

// Simple Painter to simulate the line graph in your screenshot
class SimpleLineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.9, size.width * 0.4, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.6, size.height * 0.1, size.width * 0.8, size.height * 0.6);
    path.lineTo(size.width, size.height * 0.2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}