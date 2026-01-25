import 'package:echotune/modules/user/explore/views/widgets/artist_tab_body.dart';
import 'package:echotune/modules/user/explore/views/widgets/content_tab_body.dart';
import 'package:echotune/modules/user/explore/views/widgets/explore_grid_items.dart';
import 'package:echotune/modules/user/explore/views/widgets/music_tab_body.dart';
import 'package:echotune/modules/user/explore/views/widgets/playing_overlay.dart'; // New Overlay
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/explore_controller.dart';

class ExploreView extends StatelessWidget {
  final ExploreController controller = Get.put(ExploreController());

   ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildExploreApp(),
      // Use Stack to layer the PlayingOverlay over the main content
      body: Stack(
        children: [
          Column(
            children: [
              _buildExploreTabBar(),
              Expanded(
                child: TabBarView(
                  controller: controller.exploreTabController,
                  children: [
                    _buildAllTabContent(),
                    MusicTabBody(),
                    ContentTabBody(),
                    ArtistTabBody(),
                  ],
                ),
              ),
              // Persistent Bottom Bar shown in Music/Content tabs
              _buildbottomPlayerBar(),
            ],
          ),

          // Video Player Overlay that appears when a track is selected
          PlayingOverlay(),
        ],
      ),
    );
  }

  Widget _buildExploreTabBar() {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200))
      ),
      child: TabBar(
        controller: controller.exploreTabController,
        isScrollable: false,
        indicatorColor: const Color(0xFFE5B25D), // Gold
        labelColor: const Color(0xFFE5B25D),
        unselectedLabelColor: Colors.grey,
        tabs: const [
          Tab(text: "All"),
          Tab(text: "Music"),
          Tab(text: "Content"),
          Tab(text: "Artist"),
        ],
      ),
    );
  }

  Widget _buildAllTabContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Explore", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  const Icon(Icons.tune), // Filter
                  const SizedBox(width: 15),
                  const Icon(Icons.search),
                ],
              )
            ],
          ),
          const SizedBox(height: 30),
          _buildSectionHeader("Music"),
          const SizedBox(height: 10),
          _buildExploreGrid(),
          const SizedBox(height: 30),
          _buildSectionHeader("Content"),

          _buildExploreGrid(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
        const Text("Explore All", style: TextStyle(color: Colors.black, fontSize: 12)),
      ],
    );
  }

  Widget _buildExploreGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) => const ExploreGridItem(),
    );
  }

  PreferredSizeWidget _buildExploreApp() {
    return AppBar(
      backgroundColor: const Color(0xFF1A1A1A),
      elevation: 0,
      leadingWidth: 140,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("ECHOTUNE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            Text("YOUR SOUND, YOUR WORLD", style: TextStyle(color: Colors.white, fontSize: 8)),
          ],
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white),
            padding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          child: const Text("Report Content Privacy", style: TextStyle(color: Colors.white, fontSize: 10)),
        ),
        const SizedBox(width: 10),
        const Icon(Icons.shopping_cart_outlined, color: Colors.white),
        const SizedBox(width: 10),
        const CircleAvatar(radius: 15, backgroundImage: AssetImage('assets/images/profile.png')),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildbottomPlayerBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A), // Dark background from your screenshot
        border: Border(
          top: BorderSide(color: Colors.white10, width: 0.5),
        ),
      ),
      child: SafeArea(
        top: false, // Prevents extra padding at the top if inside a Column
        child: Row(
          children: [
            // Play Button
            const Icon(Icons.play_circle_outline, color: Colors.white, size: 40),
            const SizedBox(width: 12),

            // Song Info
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Lorem Ipsum Dolor Sit",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "by Lorem",
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                  ),
                ],
              ),
            ),

            // Action Icons
            Row(
              children: [
                _buildPlayerAction(Icons.volume_up_outlined),
                _buildPlayerAction(Icons.link),
                _buildPlayerAction(Icons.favorite_border),
                _buildPlayerAction(Icons.file_download_outlined),
                const SizedBox(width: 8),
                // Cart icon often has a circular gold border in this UI
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE5B25D), width: 1),
                  ),
                  child: const Icon(Icons.shopping_cart_outlined, color: Color(0xFFE5B25D), size: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerAction(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }
}