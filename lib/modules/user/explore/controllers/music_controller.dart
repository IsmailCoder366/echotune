import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import '../../../../core/models/content_model.dart';

class MusicController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Observables
  var isMusicPlayerVisible = false.obs;
  var isPlaying = false.obs;
  var selectedMusic = Rxn<ContentModel>();

  // Mock Data with Network Audio URLs
  final List<ContentModel> musicList = [
    ContentModel(
      title: "Midnight City",
      artist: "by Synth Wave",
      imageUrl: "https://picsum.photos/id/103/200/200",
      videoUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3",
    ),
    ContentModel(
      title: "Lo-Fi Dreams",
      artist: "by Chill Hop",
      imageUrl: "https://media.istockphoto.com/id/505965144/photo/love-music-concept.jpg?s=612x612&w=0&k=20&c=BFnb2dLisCbyeVB9HkpoUBLBF6rAP9XslFwQlWn4bJc=",
      videoUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3",
    ),
    ContentModel(
      title: "Urban Jungle",
      artist: "by Street Beats",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTF3sdH4soSiSG79ZhWAQGnLv3rBTPqCfDmUQ&s",
      videoUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3",
    ),
    ContentModel(
      title: "Midnight City",
      artist: "by Synth Wave",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTS2VR60T1Hgqczq8BRGYLjyeyRi6R49JF-9Q&s",
      videoUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3",
    ),
    ContentModel(
      title: "Lo-Fi Dreams",
      artist: "by Chill Hop",
      imageUrl: "https://picsum.photos/id/102/200/200",
      videoUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3",
    ),
    ContentModel(
      title: "Urban Jungle",
      artist: "by Street Beats",
      imageUrl: "https://picsum.photos/id/103/200/200",
      videoUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3",
    ),
  ];

  void playNext() {
    if (selectedMusic.value == null) return;

    // Find current index
    int currentIndex = musicList.indexOf(selectedMusic.value!);
    // Move to next (loop back to start if at the end)
    int nextIndex = (currentIndex + 1) % musicList.length;

    playMusic(musicList[nextIndex]);
  }
  void playPrevious() {
    if (selectedMusic.value == null) return;

    int currentIndex = musicList.indexOf(selectedMusic.value!);
    // Move to previous (loop to end if at the start)
    int prevIndex = (currentIndex - 1 + musicList.length) % musicList.length;

    playMusic(musicList[prevIndex]);
  }
  void closeMusicPlayer() {
    isMusicPlayerVisible.value = false;
    _audioPlayer.stop();
    isPlaying.value = false;
  }

  void playMusic(ContentModel music) async {
    selectedMusic.value = music;
    isMusicPlayerVisible.value = true;
    try {
      await _audioPlayer.setUrl(music.videoUrl);
      _audioPlayer.play();
      isPlaying.value = true;
    } catch (e) {
      Get.snackbar("Error", "Could not load audio");
    }
  }

  void togglePlayPause() {
    if (_audioPlayer.playing) {
      _audioPlayer.pause();
      isPlaying.value = false;
    } else {
      _audioPlayer.play();
      isPlaying.value = true;
    }
  }

  @override
  void onClose() {
    _audioPlayer.dispose(); // Cleanup to prevent memory leaks
    super.onClose();
  }
}