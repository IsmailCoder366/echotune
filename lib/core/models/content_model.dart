// Put this in a new file or at the top of your controller
class ContentModel {
  final String title;
  final String artist;
  final String imageUrl;
  final String videoUrl; // For your dummy video data

  ContentModel({
    required this.title,
    required this.artist,
    required this.imageUrl,
    required this.videoUrl
  });
}