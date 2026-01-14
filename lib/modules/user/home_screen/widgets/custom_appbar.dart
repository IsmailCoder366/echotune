import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/services/auth_services.dart';
import '../../profile/bottom_view/bottom_sheet_view.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Adding a boolean flag is the simplest way to override behavior per screen
  final bool isLandingPage;

  const CustomHomeAppBar({super.key, this.isLandingPage = true});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    // Access the global Auth Service
    final authService = Get.find<AuthService>();

    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: _buildLogo(),
      actions: [
        _buildComplaintButton(),
        const SizedBox(width: 8),

        // Use Obx to reactively change the button
        Obx(() {
          if (authService.isLoggedIn.value && !isLandingPage) {
            // Show Profile/Cart/User icon if logged in on Home View
            return _buildUserActions();
          } else {
            // Show Login button on Landing View
            return _buildLoginButton();
          }
        }),
      ],
    );
  }

  Widget _buildLogo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("ECHOTUNE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 15)),
        Text("YOUR SOUND YOUR WORLD", style: TextStyle(color: Colors.white, fontSize: 6)),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 12, bottom: 12),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text("Login", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildUserActions() {
    return Row(
      children: [
        const Icon(Icons.shopping_cart_outlined, color: Colors.white),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => showProfileBottomSheet(), // Function from previous step
          child: const CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
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
        child: const Text("Complaint Music Use", style: TextStyle(fontSize: 10)),
      ),
    );
  }
}