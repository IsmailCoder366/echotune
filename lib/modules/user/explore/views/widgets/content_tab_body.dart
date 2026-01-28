import 'package:echotune/modules/user/explore/views/widgets/content_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../controllers/explore_controller.dart';

class ContentTabBody extends StatelessWidget {
  final ExploreController controller = Get.find<ExploreController>();

  ContentTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // We use Obx so the screen "wakes up" and redraws when the controller says a video started
      body: Obx(() =>Stack(
        children: [
          // LAYER 1: The Main List (The bottom layer)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildHeader(),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.separated(
                    itemCount: controller.contentList.length,
                    separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.black12),
                    itemBuilder: (context, index) {
                      final item = controller.contentList[index]; // Get the specific item
                      return ContentTile(
                        title: item.title,
                        artist: item.artist,
                        imageUrl: item.imageUrl, // Pass the unique image
                        onPlayTap: () => controller.playTrack(item),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // LAYER 2: The Video Preview (The top layer)
          // Only show this "sticker" if the controller says a track is actually playing
          if (controller.isPlayerVisible.value)
            Positioned(
              bottom: 20, // Keep it near the bottom like the image
              left: 10,
              right: 10,
              child: _buildVideoPreview(context),
            ),
        ],
      ))
    );
  }

  Widget _buildVideoPreview(BuildContext context) {
    final selectedData = controller.selectedContent.value;

    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // 1. THE VIDEO AREA + TAP TO WAKE UP
          GestureDetector(
            onTap: () => controller.triggerCenterControl(), // Tapping video shows the button
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Obx(() => controller.isVideoInitialized.value
                  ? AspectRatio(
                aspectRatio: controller.videoController!.value.aspectRatio,
                child: VideoPlayer(controller.videoController!),
              )
                  : const Center(child: CircularProgressIndicator(color: Colors.white)),
              ),
            ),
          ),

          // 2. CINEMATIC OVERLAY (Now reactive - fades with the button)
          Obx(() => AnimatedOpacity(
            opacity: controller.showCenterControl.value ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Container(color: Colors.black.withOpacity(0.3)),
          )),

          // 3. THE CLOSE BUTTON (Always stays visible so you can exit)
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () => controller.closePlayer(),
              child: const Icon(Icons.close, color: Colors.white, size: 28),
            ),
          ),

          // 4. THE CENTER PLAY/PAUSE BUTTON (The "Magic" fading button)
          Center(
            child: Obx(() => AnimatedOpacity(
              opacity: controller.showCenterControl.value ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: GestureDetector(
                onTap: () => controller.togglePlayPause(),
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.black45,
                  child: Icon(
                    controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            )),
          ),

          // 5. THE BOTTOM CONTROLS (Fades in/out with the center button)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Obx(() => AnimatedOpacity(
              opacity: controller.showCenterControl.value ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: _buildPlayerControls(),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerControls() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black.withOpacity(0.8), Colors.transparent],
        ),
      ),
      child: Obx(() => Column(
        children: [
          // THE SLIDER: Moves as the video plays
          Slider(
            value: controller.videoPosition.value.inSeconds.toDouble(),
            max: controller.videoDuration.value.inSeconds.toDouble(),
            onChanged: (v) => controller.seekTo(v),
            activeColor: Colors.blue,
            inactiveColor: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // BACKWARD 10s
              IconButton(
                icon: const Icon(Icons.replay_10, color: Colors.white),
                onPressed: () => controller.seekBackward(),
              ),
              // PLAY / PAUSE
              IconButton(
                icon: Icon(
                  controller.isPlayerVisible.value ? Icons.pause_circle_filled : Icons.play_circle_filled,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () => controller.togglePlayPause(),
              ),
              // FORWARD 10s
              IconButton(
                icon: const Icon(Icons.forward_10, color: Colors.white),
                onPressed: () => controller.seekForward(),
              ),
              const Spacer(),
              // TIME TEXT
              Text(
                "${controller.formatDuration(controller.videoPosition.value)} / ${controller.formatDuration(controller.videoDuration.value)}",
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          )
        ],
      )),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Explore", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.tune, color: Colors.black)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.black)),
          ],
        )
      ],
    );
  }
}