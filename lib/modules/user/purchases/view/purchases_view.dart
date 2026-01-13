import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../landing/view/widgets/custom_appbar.dart';
import '../controllers/purchases_controller.dart';
import '../widgets/purchase_item_tile.dart';

class PurchasesView extends StatelessWidget {
  const PurchasesView({super.key});

  @override
  Widget build(BuildContext context) {
    final PurchasesController controller =
    Get.put(PurchasesController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16.0, top: 10),
          child: Column(
            children: [
              Text("ECHOTUNE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              Text("YOUR SOUND, YOUR WORLD", style: TextStyle(color: Colors.white, fontSize: 8)),

            ],
          ),
        ),
        leadingWidth: 130,
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
          const CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage('assets/images/profile.png'), // User profile image
          ),
          const SizedBox(width: 16),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubHeader(),
            const SizedBox(height: 16),

            /// Title + Search icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Text(
                  "List of Purchases",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black
                        ),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Icon(Icons.search, size: 22)),
              ],
            ),

            const SizedBox(height: 12),

            /// LIST
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.purchases.length,
                  itemBuilder: (context, index) {
                    return PurchaseItemTile(
                      title: controller.purchases[index],
                      subtitle: "by Lorem",
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}





Widget _buildSubHeader() {
  return Container(
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _tabItem("Purchases", isSelected: true),
        _tabItem("Favourites"),
        _tabItem("User info"),
      ],
    ),
  );
}
Widget _tabItem(String title, {bool isSelected = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 15),
    decoration: BoxDecoration(
      border: isSelected ? const Border(bottom: BorderSide(color: Color(0xFFE5B25D), width: 2)) : null,
    ),
    child: Text(
      title,
      style: TextStyle(
        color: isSelected ? const Color(0xFFE5B25D) : Colors.grey,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  );
}