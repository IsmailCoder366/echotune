import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/constants/app_colors.dart';
import '../../controllers/purchases_controller.dart';

class FavouritesTab extends StatelessWidget {
  final PurchasesController controller;
  const FavouritesTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.favoriteItems.isEmpty) {
        return const Center(child: Text("No Favourites Yet", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)));
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.separated(
          padding: const EdgeInsets.only(top: 20),
          itemCount: controller.favoriteItems.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) => _buildFavTile(controller.favoriteItems[index]),
        ),
      );
    });
  }

  Widget _buildFavTile(String title) {
    return ListTile(
      leading: const Icon(Icons.play_circle_outline, size: 40, color: Colors.black87),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: const Text("by Lorem", style: TextStyle(color: Colors.grey, fontSize: 10)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.favorite, color: Colors.black),
          const SizedBox(width: 10),
          Container(
            height: 30, width: 30,
            decoration: BoxDecoration(border: Border.all(color: AppColors.primaryColor), shape: BoxShape.circle),
            child: const Icon(Icons.shopping_cart, color: AppColors.primaryColor, size: 18),
          ),
        ],
      ),
    );
  }
}