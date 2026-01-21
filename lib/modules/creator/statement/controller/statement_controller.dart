import 'package:get/get.dart';

class StatementController extends GetxController {
  // Observables for the summary cards
  var overallTotal = "270".obs;
  var musicTotal = "200".obs;
  var contentTotal = "70".obs;

  // Observable list for the transaction data
  var transactions = <Map<String, String>>[
    {"date": "Aug 12 2022", "time": "12:00 PM", "name": "Michael Jordan"},
    {"date": "Aug 12 2022", "time": "12:00 PM", "name": "Michael Jordan"},
  ].obs;
}