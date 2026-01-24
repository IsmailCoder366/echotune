import 'package:echotune/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../data/repositories/auth_repository.dart'; // Adjust path
import '../../../../core/utils/app_validators.dart';
import '../model/profile_menu_model.dart';
import '../../purchases/controllers/purchases_controller.dart';

class ProfileController extends GetxController {
  // Inject the Auth Repository
  final AuthRepository _authRepo = AuthRepository();

  final RxString userName = "Michael Jordan".obs;
  var isLoggingOut = false.obs;

  /// Navigates to the PurchasesView and sets the active tab
  void goToTargetTab(int tabIndex) {
    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }

    Get.toNamed(Routes.userPurchases);

    Future.delayed(const Duration(milliseconds: 100), () {
      if (Get.isRegistered<PurchasesController>()) {
        Get.find<PurchasesController>().jumpToTab(tabIndex);
      }
    });
  }

  List<ProfileMenuModel> get menuItems => [
    ProfileMenuModel(title: "Purchases", onTap: () => goToTargetTab(0)),
    ProfileMenuModel(title: "Favourites", onTap: () => goToTargetTab(1)),
    ProfileMenuModel(title: "User Info.", onTap: () => goToTargetTab(2)),
  ];

  // --- Linked Logout Logic ---
  void logout() async {
    // 1. Close bottom sheet/dialog if open
    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }

    try {
      isLoggingOut.value = true;

      // 2. Call Firebase Logout from Repo
      await _authRepo.logout();

      AppValidators.showMessage("Logged out successfully", isError: false);

      // 3. Navigate to Login and clear the entire navigation stack
      // This prevents the user from going 'back' into the User Module
      Get.offAllNamed(Routes.login);

    } catch (e) {
      AppValidators.showMessage("Logout failed. Please try again.");
    } finally {
      isLoggingOut.value = false;
    }
  }
}