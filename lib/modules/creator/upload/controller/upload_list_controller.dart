import 'package:get/get.dart';

class UploadListController extends GetxController {
  // Observable list of uploads
  var uploads = <Map<String, String>>[
    {
      "type": "Music",
      "name": "Demo music",
      "link": "Https://EchoTune.com/"
    },
    {
      "type": "Music",
      "name": "Demo music",
      "link": "Https://EchoTune.com/"
    },
  ].obs;

  void editSongName(int index) {
    // Logic for editing song name
  }
}