import 'package:get/get.dart';

import '../model/profile_menu_model.dart';


class ProfileController extends GetxController {
  final String userName = "Michael Jordan";

  List<ProfileMenuModel> get menuItems => [
    ProfileMenuModel(title: "Purchases", onTap: () => print("Purchases clicked")),
    ProfileMenuModel(title: "Favourites", onTap: () => print("Favourites clicked")),
    ProfileMenuModel(title: "User Info.", onTap: () => print("User Info clicked")),
  ];

  void logout() {
    Get.back(); // Close bottom sheet
    print("Logged out");
  }
}