import 'package:echotune/app/routes/app_routes.dart';
import 'package:get/get.dart';
import '../model/profile_menu_model.dart';


class ProfileController extends GetxController {
  final String userName = "Michael Jordan";

  void goToPurchases() {
    // 1. Close the bottom sheet
    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }

    // 2. Execute the navigation to the named route
    Get.toNamed(Routes.userPurchases);
  }
  List<ProfileMenuModel> get menuItems => [
    ProfileMenuModel(title: "Purchases", onTap: () => goToPurchases()),
    ProfileMenuModel(title: "Favourites", onTap: () => print("Favourites clicked")),
    ProfileMenuModel(title: "User Info.", onTap: () => print("User Info clicked")),
  ];

  void logout() {
    Get.back(); // Close bottom sheet
    print("Logged out");
  }
}