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
    final currentSong = musicController.selectedMusic.value;
    if (currentSong == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => musicController.togglePlayPause(),
              child: Obx(() => Icon(
                musicController.isPlaying.value ? Icons.pause_circle_filled : Icons.play_circle_filled,
                color: Colors.white,
                size: 45,
              )),
            ),
            const SizedBox(width: 12),
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
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                  ),
                ],
              ),
            ),
            // Actions
            _buildPlayerAction(Icons.favorite_border),
            _buildPlayerAction(Icons.file_download_outlined),
          ],
        ),
      ),
    );
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