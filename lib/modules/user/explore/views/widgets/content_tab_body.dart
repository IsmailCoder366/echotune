import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../controllers/content_controller.dart';
import 'content_tile.dart';

class ContentTabBody extends StatelessWidget {
  final ContentController contentController = Get.put(ContentController());

  ContentTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => Stack(
        children: [
          // LAYER 1: The Main List
          _buildMainContentList(),

          // LAYER 2: The Inactive Background (Dimmer)
          if (contentController.isPlayerVisible.value)
            GestureDetector(
              onTap: () => contentController.closePlayer(),
              child: Container(
                color: Colors.black.withOpacity(0.6), // Dimmed background
              ),
            ),

          // LAYER 3: The Video Preview (Centered or Full Screen)
          if (contentController.isPlayerVisible.value)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: contentController.isFullScreen.value ? 0 : 20,
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: contentController.isFullScreen.value
                      ? MediaQuery.of(context).size.height
                      : 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(
                        contentController.isFullScreen.value ? 0 : 12),
                  ),
                  child: _buildVideoPreview(context),
                ),
              ),
            ),
        ],
      )),
    );
  }

  Widget _buildMainContentList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildHeader(),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: contentController.contentList.length,
              separatorBuilder: (context, index) =>
              const Divider(height: 1, color: Colors.black12),
              itemBuilder: (context, index) {
                final item = contentController.contentList[index];
                return ContentTile(
                  title: item.title,
                  artist: item.artist,
                  imageUrl: item.imageUrl,
                  onPlayTap: () => contentController.playTrack(item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPreview(BuildContext context) {
    return Stack(
      children: [
        // 1. THE VIDEO AREA (Tap to wake up controls or toggle play/pause)
        GestureDetector(
          onTap: () {
            // Logic: If playing, wake up the UI. If paused, icons stay visible.
            if (contentController.isPlaying.value) {
              contentController.triggerCenterControl();
            } else {
              contentController.togglePlayPause();
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                contentController.isFullScreen.value ? 0 : 12),
            child: Center(
              child: contentController.isVideoInitialized.value
                  ? AspectRatio(
                aspectRatio:
                contentController.videoController!.value.aspectRatio,
                child: VideoPlayer(contentController.videoController!),
              )
                  : const CircularProgressIndicator(color: Colors.white),
            ),
          ),
        ),

        // 2. OVERLAY CONTROLS (Center Play/Pause & Dark Tint)
        Obx(() => AnimatedOpacity(
          opacity: contentController.showCenterControl.value ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 400),
          child: IgnorePointer(
            ignoring: !contentController.showCenterControl.value,
            child: Stack(
              children: [
                Container(color: Colors.black26), // Slight tint
                Center(
                  child: IconButton(
                    iconSize: 70,
                    icon: Icon(
                      contentController.isPlaying.value
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      color: Colors.white,
                    ),
                    onPressed: () => contentController.togglePlayPause(),
                  ),
                ),
              ],
            ),
          ),
        )),

        // 3. CLOSE BUTTON (Always clickable if visible)
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 28),
            onPressed: () => contentController.closePlayer(),
          ),
        ),

        // 4. BOTTOM CONTROLS (Slider + Player Bar)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Obx(() => AnimatedOpacity(
            opacity: contentController.showCenterControl.value ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 400),
            child: IgnorePointer(
              ignoring: !contentController.showCenterControl.value,
              child: _buildPlayerControls(),
            ),
          )),
        ),
      ],
    );
  }

  Widget _buildPlayerControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black.withOpacity(0.8), Colors.transparent],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Slider wrapped in its own Obx for smooth movement
          Obx(() => SliderTheme(
            data: SliderTheme.of(Get.context!).copyWith(
              trackHeight: 2,
              thumbShape:
              const RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayShape:
              const RoundSliderOverlayShape(overlayRadius: 14),
            ),
            child: Slider(
              value: contentController.videoPosition.value.inSeconds
                  .toDouble(),
              max: contentController.videoDuration.value.inSeconds
                  .toDouble(),
              onChanged: (v) => contentController.seekTo(v),
              activeColor: Colors.blue,
              inactiveColor: Colors.white30,
            ),
          )),
          Row(
            children: [
              // Bottom Left Actions
              IconButton(
                icon: Icon(
                    contentController.isPlaying.value
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white),
                onPressed: () => contentController.togglePlayPause(),
              ),
              IconButton(
                icon: const Icon(Icons.replay_10, color: Colors.white, size: 22),
                onPressed: () => contentController.seekBackward(),
              ),
              IconButton(
                icon:
                const Icon(Icons.forward_10, color: Colors.white, size: 22),
                onPressed: () => contentController.seekForward(),
              ),
              const Spacer(),
              // Time Labels
              Obx(() => Text(
                "${contentController.formatDuration(contentController.videoPosition.value)} / ${contentController.formatDuration(contentController.videoDuration.value)}",
                style: const TextStyle(color: Colors.white, fontSize: 11),
              )),
              // Full Screen Toggle
              IconButton(
                icon: Icon(
                  contentController.isFullScreen.value
                      ? Icons.fullscreen_exit
                      : Icons.fullscreen,
                  color: Colors.white,
                ),
                onPressed: () => contentController.toggleFullScreen(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Explore",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.tune, color: Colors.black)),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, color: Colors.black)),
          ],
        )
      ],
    );
  }
}