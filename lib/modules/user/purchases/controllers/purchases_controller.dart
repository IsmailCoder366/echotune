import 'package:get/get.dart';

class PurchasesController extends GetxController {
  var purchases = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    // dummy data
    purchases.value = [
      "Lorem Ipsum Dolor Sit",
      "Lorem Ipsum Dolor Sit",
      "Lorem Ipsum Dolor Sit",
      "Lorem Ipsum Dolor Sit",
      "Lorem Ipsum Dolor Sit",
    ];
  }
}
