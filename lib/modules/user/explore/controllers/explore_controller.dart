import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/models/content_model.dart';

class ExploreController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController exploreTabController;

  // --- Observables ---
  var isPlayerVisible = false.obs;      // Controls if the overlay is on screen
  var isVideoInitialized = false.obs;   // Controls if the loader is shown
  var isPlaying = false.obs;            // Tracks play/pause state specifically
  var showCenterControl = true.obs;     // Controls the "Flash and Hide" button

  var selectedContent = Rxn<ContentModel>();
  var videoPosition = Duration.zero.obs;
  var videoDuration = Duration.zero.obs;

  // The Remote Control
  VideoPlayerController? videoController;

  final List<ContentModel> contentList = [
    ContentModel(
      title: "Nature Melodies",
      artist: "by Forest Echo",
      imageUrl: "https://picsum.photos/id/10/200/200",
      videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    ),
    ContentModel(
      title: "Urban Beats",
      artist: "by City Lights",
      imageUrl: "https://picsum.photos/id/20/200/200",
      videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    ),
    ContentModel(
      title: "Ocean Waves",
      artist: "by Deep Blue",
      imageUrl: "https://picsum.photos/id/30/200/200",
      videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    ),
  ];

  void playTrack(ContentModel content) async {
    selectedContent.value = content;
    isPlayerVisible.value = true;
    showCenterControl.value = true; // Show play button immediately when opening

    if (videoController != null) {
      await videoController!.pause();
      await videoController!.dispose();
      videoController = null;
    }

    isVideoInitialized.value = false;

    try {
      videoController = VideoPlayerController.networkUrl(Uri.parse(content.videoUrl));
      await videoController!.initialize();

      videoDuration.value = videoController!.value.duration;

      // LISTENER: Updates UI as video moves
      videoController!.addListener(() {
        videoPosition.value = videoController!.value.position;
        isPlaying.value = videoController!.value.isPlaying;
      });

      isVideoInitialized.value = true;
      videoController!.play();

      // Flash the button then hide it
      triggerCenterControl();

      update();
    } catch (e) {
      debugPrint("Video Error: $e");
    }
  }

  // --- FLASH AND HIDE LOGIC ---
  void triggerCenterControl() {
    showCenterControl.value = true;

    // After 1.5 seconds, hide the button ONLY if video is playing
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (videoController != null && videoController!.value.isPlaying) {
        showCenterControl.value = false;
      }
    });
  }

  void togglePlayPause() {
    if (videoController == null) return;

    if (videoController!.value.isPlaying) {
      videoController!.pause();
      showCenterControl.value = true; // Keep it visible when paused
    } else {
      videoController!.play();
      triggerCenterControl(); // Hide after a moment when playing
    }
  }

  // --- NAVIGATION ACTIONS ---
  void seekForward() {
    final newPos = videoPosition.value + const Duration(seconds: 10);
    videoController?.seekTo(newPos);
    triggerCenterControl(); // Show controls briefly when skipping
  }

  void seekBackward() {
    final newPos = videoPosition.value - const Duration(seconds: 10);
    videoController?.seekTo(newPos);
    triggerCenterControl(); // Show controls briefly when skipping
  }

  void seekTo(double seconds) {
    videoController?.seekTo(Duration(seconds: seconds.toInt()));
  }

  void closePlayer() {
    isPlayerVisible.value = false;
    videoController?.pause();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void onInit() {
    super.onInit();
    exploreTabController = TabController(length: 4, vsync: this);
  }

  @override
  void onClose() {
    exploreTabController.dispose();
    videoController?.dispose();
    super.onClose();
  }
}