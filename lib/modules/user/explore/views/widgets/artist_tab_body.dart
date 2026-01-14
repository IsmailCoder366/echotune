import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/explore_controller.dart';

class ArtistTabBody extends StatelessWidget {
  final ExploreController controller = Get.find<ExploreController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildExploreHeader(),
          const SizedBox(height: 20),
          // Artist Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.artistList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 columns for circular profiles
              mainAxisSpacing: 20,
              crossAxisSpacing: 15,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final artist = controller.artistList[index];
              return Column(
                children: [
                  // Circular Profile Image
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: AssetImage(artist['image']!),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    artist['name']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExploreHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Explore", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.tune)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ],
        )
      ],
    );
  }
}