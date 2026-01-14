import 'package:echotune/modules/user/purchases/view/widgets/favourite_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/purchases_controller.dart';
import 'widgets/purchases_tab.dart';
import 'widgets/user_info_tab.dart';

class PurchasesView extends StatelessWidget {
  final PurchasesController controller = Get.put(PurchasesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildTabBarHeader(),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                PurchasesTab(controller: controller), // Tab 0
                FavouritesTab(controller: controller), // Tab 1
                UserInfoTab(),                        // Tab 2
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF1A1A1A),
      elevation: 0,
      leadingWidth: 140,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("ECHOTUNE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            Text("YOUR SOUND, YOUR WORLD", style: TextStyle(color: Colors.white, fontSize: 8)),
          ],
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white),
            padding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          child: const Text("Report Content Privacy", style: TextStyle(color: Colors.white, fontSize: 10)),
        ),
        const SizedBox(width: 10),
        const Icon(Icons.shopping_cart_outlined, color: Colors.white),
        const SizedBox(width: 10),
        const CircleAvatar(radius: 15, backgroundImage: AssetImage('assets/images/profile.png')),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildTabBarHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
      child: TabBar(
        controller: controller.tabController,
        indicatorColor: const Color(0xFFE5B25D), // Gold
        labelColor: const Color(0xFFE5B25D),
        unselectedLabelColor: Colors.grey,
        indicatorWeight: 3,
        tabs: const [
          Tab(text: "Purchases"),
          Tab(text: "Favourites"),
          Tab(text: "User info"),
        ],
      ),
    );
  }
}