import 'package:get/get.dart';

class ComplainController extends GetxController {
  // Use .obs to make the list observable
  var complaints = <Map<String, String>>[
    {
      "type": "Privacy",
      "name": "Demo Song 1",
      "date_time": "Aug 12, 12:00 PM"
    },
    {
      "type": "Copyright",
      "name": "Demo Song 2",
      "date_time": "Aug 13, 01:30 PM"
    },
  ].obs;
}