import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/explore_controller.dart';
import 'music_list_tile.dart';

class MusicTabBody extends StatelessWidget {
  final ExploreController controller = Get.find<ExploreController>();

  MusicTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the Material context to fix the Red/Yellow text error
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // Shows back button only if we navigated here via Get.to()
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header with Padding
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildHeader(),
          ),

          const SizedBox(height: 10),

          // 2. Expanded must be a DIRECT child of Column
          Expanded(
            child: Padding(
              // Padding is inside Expanded to keep the list within margins
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                itemCount: 8, // Replace with controller.musicList.length later
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 20),
                separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.black12),
                itemBuilder: (context, index) {
                  return MusicListTile(
                    title: "Lorem Ipsum Dolor Sit",
                    artist: "by Lorem",
                    onPlayTap: () {
                      controller.playTrack(
                          "Lorem Ipsum Dolor Sit",
                          "by Lorem"
                      );
                    },
                  );
                },
              ),
            ),
          ),

          // 3. Bottom Player Bar
          _buildbottomPlayerBar(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Explore",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.tune, color: Colors.black)
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, color: Colors.black)
            ),
          ],
        )
      ],
    );
  }

  Widget _buildbottomPlayerBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A), // Dark player background
        border: Border(top: BorderSide(color: Colors.white10, width: 0.5)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            const Icon(
              Icons.play_circle_outline,
              color: Colors.white,
              size: 40,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Lorem Ipsum Dolor Sit",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "by Lorem",
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _buildPlayerAction(Icons.volume_up_outlined),
                _buildPlayerAction(Icons.link),
                _buildPlayerAction(Icons.favorite_border),
                _buildPlayerAction(Icons.file_download_outlined),
                const SizedBox(width: 8),
                // Gold themed cart icon for the project
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE5B25D),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Color(0xFFE5B25D),
                    size: 18,
                  ),
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