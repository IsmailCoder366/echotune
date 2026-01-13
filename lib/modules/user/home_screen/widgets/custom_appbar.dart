import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "ECHOTUNE",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 15,
              letterSpacing: 1.2,
            ),
          ),
          Text(
            "YOUR SOUND YOUR WORLD",
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 6, // Small tagline style
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
      actions: [
        // The "Complaint Music Use" button
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white70),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            child: const Text("Complaint Music Use", style: TextStyle(fontSize: 10)),
          ),
        ),
        const SizedBox(width: 8),
        // The Login Button
        Padding(
          padding: const EdgeInsets.only(right: 16, top: 12, bottom: 12),
          child: ElevatedButton(
            onPressed: () {
              // Navigates to the route name you defined in your GetMaterialApp
              Get.toNamed('/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text("Login", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}