import 'package:echotune/modules/user/explore/views/widgets/content_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/explore_controller.dart';
import 'music_list_tile.dart';

class ContentTabBody extends StatelessWidget {
  // Get.find retrieves the existing ExploreController instance
  final ExploreController controller = Get.find<ExploreController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          // Explore Header with Filter and Search
          _buildHeader(),
          const SizedBox(height: 10),
          // List of Content Items
          Expanded(
            child: ListView.separated(
              itemCount: 5, // Replace with controller.contentList.length
              padding: const EdgeInsets.only(bottom: 100), // Space for bottom player
              separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.black12),
              itemBuilder: (context, index) {
                return  ContentTile(
                  title: "Lorem Ipsum Dolor Sit",
                  artist: "by Lorem",
                  // 1. Change 'onTap' to 'onPlayTap'
                  // 2. Remove the extra inner 'onPlayTap: () {}'
                  onPlayTap: () {
                    // This logic triggers when the thumbnail/play button is clicked
                    controller.playTrack("Lorem Ipsum Dolor Sit", "by Lorem");
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
            // Reusable Filter icon from design
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.tune, color: Colors.black)
            ),
            // Reusable Search icon from design
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