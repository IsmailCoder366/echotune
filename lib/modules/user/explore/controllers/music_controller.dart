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
      imageUrl: "https://picsum.photos/id/101/200/200",
      videoUrl: "https://www.chosic.com/wp-content/uploads/2021/07/The-Show-Must-Be-Go.mp3",
    ),
    ContentModel(
      title: "Lo-Fi Dreams",
      artist: "by Chill Hop",
      imageUrl: "https://picsum.photos/id/102/200/200",
      videoUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3",
    ),
    ContentModel(
      title: "Urban Jungle",
      artist: "by Street Beats",
      imageUrl: "https://picsum.photos/id/103/200/200",
      videoUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3",
    ),
  ];

  void playMusic(ContentModel music) async{
    selectedMusic.value = music;
    isMusicPlayerVisible.value = true;
    try {
      // 2. Load and Play the URL
      await _audioPlayer.setUrl(music.videoUrl);
      _audioPlayer.play();
      isPlaying.value = true;
    } catch (e) {
      print("Error loading audio: $e");
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