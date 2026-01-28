import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/explore_controller.dart';
import '../../controllers/music_controller.dart';
import 'music_list_tile.dart';

class MusicTabBody extends StatelessWidget {
  final ExploreController exploreController = Get.find<ExploreController>();
  final MusicController musicController = Get.put(MusicController());

  MusicTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack( // Use Stack to overlay the player on the list
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildHeader(),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: _buildMusicList(),
              ),
            ],
          ),

          // 3. THE ANIMATED BOTTOM PLAYER
          Obx(() => Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 300),
              offset: musicController.isMusicPlayerVisible.value
                  ? Offset.zero
                  : const Offset(0, 1), // Slides down off-screen
              child: _buildbottomPlayerBar(),
            ),
          )),
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
    return Obx(() {
      final currentSong = musicController.selectedMusic.value;
      if (currentSong == null) return const SizedBox.shrink();

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: const BoxDecoration(
          color: Color(0xFF1A1A1A),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10)],
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  // 1. PROJECT ICON / THUMBNAIL
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(currentSong.imageUrl, height: 45, width: 45, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 12),

                  // 2. SONG INFO
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentSong.title,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          currentSong.artist,
                          style: TextStyle(color: Colors.grey.shade400, fontSize: 11),
                        ),
                      ],
                    ),
                  ),

                  // 3. PLAYBACK CONTROLS
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.skip_previous, color: Colors.white, size: 28),
                        onPressed: () => musicController.playPrevious(),
                      ),
                      IconButton(
                        icon: Icon(
                          musicController.isPlaying.value ? Icons.pause_circle_filled : Icons.play_circle_filled,
                          color: const Color(0xFFE5B25D), // Gold Theme
                          size: 40,
                        ),
                        onPressed: () => musicController.togglePlayPause(),
                      ),
                      IconButton(
                        icon: const Icon(Icons.skip_next, color: Colors.white, size: 28),
                        onPressed: () => musicController.playNext(),
                      ),
                    ],
                  ),

                  // 4. CLOSE BUTTON
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white54, size: 20),
                    onPressed: () => musicController.closeMusicPlayer(),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
  Widget _buildMusicList() {
    return ListView.separated(
      itemCount: musicController.musicList.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 100, left: 20, right: 20),
      separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.black12),
      itemBuilder: (context, index) {
        final song = musicController.musicList[index];
        return MusicListTile(
          title: song.title,
          artist: song.artist,
          onPlayTap: () => musicController.playMusic(song),
        );
      },
    );
  }
  Widget _buildPlayerAction(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }
}