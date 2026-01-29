import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/models/content_model.dart';

class ContentController extends GetxController {
  var isPlayerVisible = false.obs;
  var isVideoInitialized = false.obs;
  var isPlaying = false.obs;
  var showCenterControl = true.obs;
  var isFullScreen = false.obs;

  var selectedContent = Rxn<ContentModel>();
  var videoPosition = Duration.zero.obs;
  var videoDuration = Duration.zero.obs;

  VideoPlayerController? videoController;

  void toggleFullScreen() {
    isFullScreen.value = !isFullScreen.value;
  }

  void togglePlayPause() {
    if (videoController == null || !videoController!.value.isInitialized) return;

    if (videoController!.value.isPlaying) {
      videoController!.pause();
      showCenterControl.value = true;
    } else {
      videoController!.play();
      triggerCenterControl();
    }
  }

  void playTrack(ContentModel content) async {
    selectedContent.value = content;
    isPlayerVisible.value = true;
    showCenterControl.value = true;
    isVideoInitialized.value = false; // Show loader on mobile immediately

    // Dispose old controller properly
    if (videoController != null) {
      videoController!.removeListener(_videoListener); // Clean up listener
      await videoController!.pause();
      await videoController!.dispose();
      videoController = null;
    }

    try {
      // FIX 1: Ensure URL is HTTPS (Very important for Mobile)
      String secureUrl = content.videoUrl.replaceFirst("http://", "https://");

      videoController = VideoPlayerController.networkUrl(Uri.parse(secureUrl));

      await videoController!.initialize();

      // FIX 2: Set duration after initialization
      videoDuration.value = videoController!.value.duration;
      videoController!.addListener(_videoListener);

      isVideoInitialized.value = true;

      // FIX 3: Play after a tiny frame delay to ensure mobile hardware is ready
      await videoController!.play();
      isPlaying.value = true;

      triggerCenterControl();
    } catch (e) {
      isVideoInitialized.value = false;
      debugPrint("Video Error: $e");
      Get.snackbar("Error", "Could not load video. Check internet connection.");
    }
  }

  // Separate listener to avoid memory leaks
  void _videoListener() {
    if (videoController == null) return;
    videoPosition.value = videoController!.value.position;
    isPlaying.value = videoController!.value.isPlaying;

    // Auto-reset when video ends
    if (videoPosition.value >= videoDuration.value && videoDuration.value != Duration.zero) {
      isPlaying.value = false;
      showCenterControl.value = true;
    }
  }

  void triggerCenterControl() {
    showCenterControl.value = true;
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (videoController != null && videoController!.value.isPlaying) {
        showCenterControl.value = false;
      }
    });
  }

  void seekForward() {
    final newPos = videoPosition.value + const Duration(seconds: 10);
    videoController?.seekTo(newPos > videoDuration.value ? videoDuration.value : newPos);
    triggerCenterControl();
  }

  void seekBackward() {
    final newPos = videoPosition.value - const Duration(seconds: 10);
    videoController?.seekTo(newPos < Duration.zero ? Duration.zero : newPos);
    triggerCenterControl();
  }

  void seekTo(double seconds) {
    videoController?.seekTo(Duration(seconds: seconds.toInt()));
  }

  void closePlayer() {
    isPlayerVisible.value = false;
    isFullScreen.value = false;
    videoController?.pause();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  void onClose() {
    videoController?.removeListener(_videoListener);
    videoController?.dispose();
    super.onClose();
  }

  // FIX 4: Updated Dummy Data to use HTTPS
  final List<ContentModel> contentList = [
    ContentModel(
      title: "Nature Melodies",
      artist: "by Forest Echo",
      imageUrl: "https://picsum.photos/id/10/200/200",
      videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    ),
    ContentModel(
      title: "Urban Beats",
      artist: "by City Lights",
      imageUrl: "https://picsum.photos/id/20/200/200",
      videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    ),
    ContentModel(
      title: "Ocean Waves",
      artist: "by Deep Blue",
      imageUrl: "https://picsum.photos/id/30/200/200",
      videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    ),
  ];
}