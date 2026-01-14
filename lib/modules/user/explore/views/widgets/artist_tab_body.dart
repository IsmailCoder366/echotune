import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/explore_controller.dart';
import 'explore_grid_items.dart';

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

      GridView.builder(
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