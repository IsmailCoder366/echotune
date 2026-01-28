import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/models/content_model.dart';

class ContentController extends GetxController {
  // --- Observables ---
  var isPlayerVisible = false.obs;
  var isVideoInitialized = false.obs;
  var isPlaying = false.obs;
  var showCenterControl = true.obs;

  var selectedContent = Rxn<ContentModel>();
  var videoPosition = Duration.zero.obs;
  var videoDuration = Duration.zero.obs;

  VideoPlayerController? videoController;

  // Dummy Data
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
    showCenterControl.value = true;

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

      videoController!.addListener(() {
        videoPosition.value = videoController!.value.position;
        isPlaying.value = videoController!.value.isPlaying;
      });

      isVideoInitialized.value = true;
      videoController!.play();
      triggerCenterControl();
      update();
    } catch (e) {
      debugPrint("Video Error: $e");
    }
  }

  void triggerCenterControl() {
    showCenterControl.value = true;
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
      showCenterControl.value = true;
    } else {
      videoController!.play();
      triggerCenterControl();
    }
  }

  void seekForward() {
    videoController?.seekTo(videoPosition.value + const Duration(seconds: 10));
    triggerCenterControl();
  }

  void seekBackward() {
    videoController?.seekTo(videoPosition.value - const Duration(seconds: 10));
    triggerCenterControl();
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
    return "${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  void onClose() {
    videoController?.dispose();
    super.onClose();
  }
}