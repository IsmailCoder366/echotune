import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../controllers/purchases_controller.dart';

class PurchasesTab extends StatelessWidget {
  final PurchasesController controller;
  const PurchasesTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    // Check for empty state logic from your provided code
    return controller.purchaseItems.isNotEmpty ? _buildEmptyState() : _buildPurchasesList();
  }

  Widget _buildPurchasesList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildHeaderRow(),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: controller.purchaseItems.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) => _buildMusicTile("Lorem Ipsum Dolor Sit"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("List of Purchases", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Container(
          height: 40, width: 40,
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black)),
          child: const Icon(Icons.search, size: 28),
        ),
      ],
    );
  }

  Widget _buildMusicTile(String title) {
    return ListTile(
      leading: const Icon(Icons.play_circle_outline, size: 40, color: Colors.black87),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: const Text("by Lorem", style: TextStyle(color: Colors.grey, fontSize: 10)),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildHeaderRow(),
          const SizedBox(height: 80),
          const Text('Not yet Purchased', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const Text('Browse through our large selection of royalty-free music', textAlign: TextAlign.center),
          const SizedBox(height: 20),
          ElevatedButton(

              onPressed: () => Get.toNamed('/explore'),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
            child: const Text('Explore More', style: TextStyle(color: Colors.black)),
          )
        ],
      ),
    );
  }
}