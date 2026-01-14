import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/explore_controller.dart';
import 'music_list_tile.dart';

class MusicTabBody extends StatelessWidget {
  final ExploreController controller = Get.find<ExploreController>();

   MusicTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          // Explore Header Row
          _buildHeader(),
          const SizedBox(height: 10),
          // Scrollable Music List
          Expanded(
            child: ListView.separated(
              itemCount: 8, // Replace with controller.musicList.length
              padding: const EdgeInsets.only(bottom: 100), // Space for bottom player
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
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            // Filter icon
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.tune, color: Colors.black)
            ),
            // Search icon
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, color: Colors.black)
            ),
          ],
        )
      ],
    );
  }
}