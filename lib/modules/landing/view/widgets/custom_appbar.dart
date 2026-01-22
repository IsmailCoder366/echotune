
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/auth_services.dart';
import '../../../user/profile/bottom_view/bottom_sheet_view.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isLandingPage; // true = landing page, false = creator_dashboard or others

  const CustomAppBar({super.key, this.isLandingPage = true});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<AuthService>();

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: _buildLogo(),
      actions: [
        _buildComplaintButton(),
        const SizedBox(width: 8),

        /// Reacts to login/logout state
        Obx(() {
          // If user is logged in → show profile actions everywhere
          if (authService.isLoggedIn.value) {
            return _buildUserActions();
          }

          // If user is NOT logged in but is on landing page → show login button
          if (isLandingPage) {
            return _buildLoginButton();
          }

          // If user is NOT logged in and on homepage → show nothing
          return const SizedBox.shrink();
        }),
      ],
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

  /// LOGIN BUTTON
  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 12, bottom: 12),
      child: ElevatedButton(
        onPressed: () => Get.toNamed('/login'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          "Login",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  /// USER ACTIONS WHEN LOGGED IN
  Widget _buildUserActions() {
    return Row(
      children: [
        const Icon(Icons.shopping_cart_outlined, color: Colors.white),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => showProfileBottomSheet(),
          child: const CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  /// Complaint button
  Widget _buildComplaintButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: OutlinedButton(
        onPressed: () => Get.toNamed('/complain_screen'),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white70),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          "Complaint Music Use",
          style: TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
