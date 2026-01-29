import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../profile/bottom_view/bottom_sheet_view.dart';
import '../../purchases/controllers/user_info_controller.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {

  // In your screen/tab where you call the controller:
  final UserInfoController userInfoController = Get.put(UserInfoController(), permanent: true);

  CustomHomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: _buildLogo(),
      actions: [
        _buildComplaintButton(),
        const SizedBox(width: 8),
        _buildUserActions(),


      ],
    );
  }


  Widget _buildUserActions() {
    return Row(
      children: [
        IconButton(onPressed: () {},
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.white)),
        const SizedBox(width: 10),
        GestureDetector(
            onTap: () => showProfileBottomSheet(),

            child: Obx(() {
              final imageUrl = userInfoController.profileImageUrl.value;
              return CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: imageUrl.isNotEmpty
                      ? NetworkImage(imageUrl)
                      : null,
                  child: imageUrl.isEmpty
                      ? const Icon(Icons.person, size: 20, color: Colors.white)
                      : null
              );
            })


        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildComplaintButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white70),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
            "Complaint Music Use", style: TextStyle(fontSize: 10)),
      ),
    );
  }

  /// Logo
  Widget _buildLogo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "ECHOTUNE",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 15),
        ),
        Text(
          "YOUR SOUND YOUR WORLD",
          style:
          TextStyle(color: Colors.white, fontSize: 6),
        ),
      ],
    );
  }
}