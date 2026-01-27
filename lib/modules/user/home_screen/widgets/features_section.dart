import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/constants/app_colors.dart';
import '../../explore/views/explore_view.dart';


class FeaturedSection extends StatelessWidget {
  const FeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),

            // 1. STYLED TABBAR
            TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.orange,
              indicatorSize: TabBarIndicatorSize.label,
              dividerHeight: 0,
              labelPadding: const EdgeInsets.symmetric(vertical: 0),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              tabs: const [
                Tab(height: 40, text: "Music"),
                Tab(height: 40, text: "Content"),
                Tab(height: 40, text: "Artist"),
              ],
            ),

            const SizedBox(height: 8),

            // 2. TABBAR VIEW (The Grid)
            SizedBox(
              height: 420,
              child: TabBarView(
                children: [
                  _ContentGrid(category: "Music"),
                  _ContentGrid(category: "Content"),
                  _ContentGrid(category: "Artist"),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 3. SINGLE NAVIGATION BUTTON
            SizedBox(
              width: 220, // Centered fixed-width button
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => ExploreView());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor, // Primary Gold
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                child: const Text('View All'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _ContentGrid extends StatelessWidget {
  final String category;
  const _ContentGrid({required this.category});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemCount: 4,
      itemBuilder: (context, index) => _ContentTile(label: "$category ${index + 1}"),
    );
  }
}

class _ContentTile extends StatelessWidget {
  final String label;
  const _ContentTile({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: AssetImage('assets/images/ilbum1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        // IMPORTANT: Gradient overlay to make white text readable
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.transparent,
              Colors.black
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Row(
                children: const [
                  Icon(Icons.music_note, color: Colors.white, size: 16),
                  SizedBox(width: 4),
                  Text('15 music', style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
            ),
            Positioned(
              bottom: 12,
              left: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Lorem ipsum dolor',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Top Album',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}