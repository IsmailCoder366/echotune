import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/profile_controller.dart';
import '../widgets/profile_menu_tile.dart';

void showProfileBottomSheet() {
  // Using find if the controller is already initialized in the view,
  // otherwise put it.
  final ProfileController controller = Get.isRegistered<ProfileController>()
      ? Get.find<ProfileController>()
      : Get.put(ProfileController());

  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 48), // Adjusted for better centering
              const Text(
                "Your Profile",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close, color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Welcome Text
          const Text(
            "Hello",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          // Wrapped in Obx in case the name changes dynamically
          Obx(() => Text(
            controller.userName.value,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          )),
          const SizedBox(height: 20),

          // Menu Items
          ...controller.menuItems.map((item) => ProfileMenuTile(
            title: item.title,
            onTap: item.onTap,
          )),

          const SizedBox(height: 30),

          // Log Out Button with Reactive Loading State
          SizedBox(
            width: double.infinity,
            height: 55,
            child: Obx(() => OutlinedButton(
              // Disable button if logging out to prevent multiple calls
              onPressed: controller.isLoggingOut.value ? null : () => controller.logout(),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: controller.isLoggingOut.value
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.black,
                ),
              )
                  : const Text(
                "Log Out",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}