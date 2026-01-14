import 'package:echotune/app/routes/app_routes.dart';
import 'package:get/get.dart';
import '../model/profile_menu_model.dart';
// Import the PurchasesController to interact with the TabController
import '../../purchases/controllers/purchases_controller.dart';

class ProfileController extends GetxController {
  // Use .obs to make the name reactive as per standard GetX MVVM
  final RxString userName = "Michael Jordan".obs;

  /// Navigates to the PurchasesView and sets the active tab based on selection
  void goToTargetTab(int tabIndex) {
    // 1. Close the bottom sheet if it is currently open
    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }

    // 2. Navigate to the Purchases screen using the route defined in AppRoutes
    Get.toNamed(Routes.userPurchases);

    // 3. Coordinate with the PurchasesController to switch to the correct TabBarView
    // A small delay ensures the view is mounted before animating the tab
    Future.delayed(const Duration(milliseconds: 100), () {
      if (Get.isRegistered<PurchasesController>()) {
        Get.find<PurchasesController>().jumpToTab(tabIndex);
      }
    });
  }

  /// Updated menu items to use indices: 0 (Purchases), 1 (Favourites), 2 (User Info)
  List<ProfileMenuModel> get menuItems => [
    ProfileMenuModel(
        title: "Purchases",
        onTap: () => goToTargetTab(0)
    ),
    ProfileMenuModel(
        title: "Favourites",
        onTap: () => goToTargetTab(1)
    ),
    ProfileMenuModel(
        title: "User Info.",
        onTap: () => goToTargetTab(2)
    ),
  ];

  void logout() {
    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }
  }
}