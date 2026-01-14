import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/explore_controller.dart';

class PlayingOverlay extends StatelessWidget {
  final ExploreController controller = Get.find<ExploreController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.isPlayerVisible.value) return const SizedBox.shrink();

      return Container(
        // Semi-transparent background to dim the list behind it
        color: Colors.black.withOpacity(0.3),
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black, // Dark player theme
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. Video Thumbnail & Play Button
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset('assets/images/video_preview.png', fit: BoxFit.cover),
                    ),
                    const Icon(Icons.play_arrow, color: Colors.white, size: 60),
                    // Close button in top right corner
                    Positioned(
                      top: 5, right: 5,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: controller.closePlayer,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // 2. Progress Slider
                Slider(
                  value: 0.4, // Example progress
                  onChanged: (val) {},
                  activeColor: Colors.blue, // Match the blue slider
                  inactiveColor: Colors.grey,
                ),
                // 3. Time and Controls Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.play_arrow, color: Colors.white),
                      const SizedBox(width: 10),
                      const Icon(Icons.skip_previous, color: Colors.white, size: 18),
                      const SizedBox(width: 10),
                      const Icon(Icons.skip_next, color: Colors.white, size: 18),
                      const SizedBox(width: 10),
                      const Icon(Icons.volume_up, color: Colors.white, size: 18),
                      const Spacer(),
                      const Text("03:47/10:00", style: TextStyle(color: Colors.white, fontSize: 10)),
                      const SizedBox(width: 10),
                      const Icon(Icons.settings, color: Colors.white, size: 18),
                      const SizedBox(width: 10),
                      const Icon(Icons.fullscreen, color: Colors.white, size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}