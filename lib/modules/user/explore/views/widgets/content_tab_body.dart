import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
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
                color: Colors.black.withOpacity(0.5), // Makes background look inactive
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
                  // If full screen, take whole height; else take 250
                  height: contentController.isFullScreen.value
                      ? MediaQuery.of(context).size.height
                      : 250,
                  width: double.infinity,
                  child: _buildVideoPreview(context),
                ),
              ),
            ),
        ],
      )),
    );
  }

  // Extracted List logic to keep the build method clean
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
              separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.black12),
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

  // Modified Preview to handle play/pause on tap and full screen button
  Widget _buildVideoPreview(BuildContext context) {
    return Stack(
      children: [
        // 1. THE VIDEO AREA (Tap here to Stop/Play)
        GestureDetector(
          onTap: () => contentController.togglePlayPause(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(contentController.isFullScreen.value ? 0 : 12),
            child: Obx(() => contentController.isVideoInitialized.value
                ? AspectRatio(
              aspectRatio: contentController.videoController!.value.aspectRatio,
              child: VideoPlayer(contentController.videoController!),
            )
                : const Center(child: CircularProgressIndicator(color: Colors.white)),
            ),
          ),
        ),

        // 2. OVERLAY AND BUTTONS
        Obx(() => AnimatedOpacity(
          opacity: contentController.showCenterControl.value ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: Stack(
            children: [
              Container(color: Colors.black.withOpacity(0.3)),
              Center(
                child: Icon(
                  contentController.isPlaying.value ? Icons.pause_circle : Icons.play_circle,
                  color: Colors.white,
                  size: 70,
                ),
              ),
            ],
          ),
        )),

        // 3. CLOSE BUTTON
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 28),
            onPressed: () => contentController.closePlayer(),
          ),
        ),

        // 4. BOTTOM CONTROLS (Includes Full Screen Icon)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Obx(() => AnimatedOpacity(
            opacity: contentController.showCenterControl.value ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: _buildPlayerControls(),
          )),
        ),
      ],
    );
  }

  Widget _buildPlayerControls() {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.black45,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Slider(
            value: contentController.videoPosition.value.inSeconds.toDouble(),
            max: contentController.videoDuration.value.inSeconds.toDouble(),
            onChanged: (v) => contentController.seekTo(v),
            activeColor: Colors.blue,
            inactiveColor: Colors.grey,
          ),
          Row(
            children: [
              // Play/Pause Bottom Left
              IconButton(
                icon: Icon(contentController.isPlaying.value ? Icons.pause : Icons.play_arrow, color: Colors.white),
                onPressed: () => contentController.togglePlayPause(),
              ),
              IconButton(
                icon: const Icon(Icons.replay_10, color: Colors.white, size: 20),
                onPressed: () => contentController.seekBackward(),
              ),
              IconButton(
                icon: const Icon(Icons.forward_10, color: Colors.white, size: 20),
                onPressed: () => contentController.seekForward(),
              ),
              const Spacer(),
              Text(
                "${contentController.formatDuration(contentController.videoPosition.value)} / ${contentController.formatDuration(contentController.videoDuration.value)}",
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              // Full Screen Toggle Bottom Right
              IconButton(
                icon: Icon(
                  contentController.isFullScreen.value ? Icons.fullscreen_exit : Icons.fullscreen,
                  color: Colors.white,
                ),
                onPressed: () => contentController.toggleFullScreen(),
              ),
            ],
          )
        ],
      ),
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