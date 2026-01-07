import 'package:flutter/material.dart';

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Reduced vertical padding
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // const SizedBox(height: 20), // Reduced from 30

            // 1. STYLED TABBAR (Tightened)
            TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.orange,
              indicatorSize: TabBarIndicatorSize.label,
              dividerHeight: 0, // Removes the bottom line and its space
              labelPadding: const EdgeInsets.symmetric(vertical: 0), // Tightens text
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              tabs: const [
                Tab(height: 40, text: "Music"), // Fixed height for tighter feel
                Tab(height: 40, text: "Content"),
                Tab(height: 40, text: "Artist"),
              ],
            ),

            // 2. MINIMIZED GAP
            const SizedBox(height: 8), // Reduced from 20

            // 3. TABBAR VIEW
            // Set height to precisely fit the GridView content
            SizedBox(
              height: 400, // Slightly reduced to keep it compact
              child: TabBarView(
                // physics: const BouncingScrollPhysics(), // Optional: for smoother feel
                children: [
                  _ContentGrid(category: "Music"),
                  _ContentGrid(category: "Content"),
                  _ContentGrid(category: "Artist"),
                ],
              ),
            ),
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
      // We keep shrinkWrap true but the SizedBox above controls the height
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.0, // Ensures square tiles
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
        color: Colors.grey[200], // Fallback color
        image: const DecorationImage(
          // Ensure path is exactly as in your pubspec.yaml
          image: AssetImage('assets/images/ilbum1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}