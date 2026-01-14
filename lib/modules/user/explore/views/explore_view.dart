import 'package:echotune/modules/user/explore/views/widgets/explore_grid_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/explore_controller.dart';

class ExploreView extends StatelessWidget {
  final ExploreController controller = Get.put(ExploreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildExploreAppBar(),
      body: Column(
        children: [
          _buildExploreTabBar(),
          Expanded(
            child: TabBarView(
              controller: controller.exploreTabController,
              children: [
                _buildAllTabContent(), // Tab 0: All
                const Center(child: Text("Music Tab")),
                const Center(child: Text("Content Tab")),
                const Center(child: Text("Artist Tab")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExploreTabBar() {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
      child: TabBar(
        controller: controller.exploreTabController,
        isScrollable: false,
        indicatorColor: const Color(0xFFE5B25D), // Gold Indicator
        labelColor: const Color(0xFFE5B25D),
        unselectedLabelColor: Colors.grey,
        tabs: const [
          Tab(text: "All"),
          Tab(text: "Music"),
          Tab(text: "Content"),
          Tab(text: "Artist"),
        ],
      ),
    );
  }

  Widget _buildAllTabContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Explore", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  const Icon(Icons.tune), // Filter icon
                  const SizedBox(width: 15),
                  const Icon(Icons.search),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          _buildSectionHeader("Music"),
          _buildExploreGrid(),
          const SizedBox(height: 20),
          _buildSectionHeader("Content"),
          _buildExploreGrid(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
        const Text("Explore All", style: TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildExploreGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) => const ExploreGridItem(),
    );
  }

  PreferredSizeWidget _buildExploreAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF1A1A1A),
      title: const Text("ECHOTUNE", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      actions: [
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white)),
          child: const Text("Report Content Piracy", style: TextStyle(color: Colors.white, fontSize: 10)),
        ),
        const SizedBox(width: 10),
        const Icon(Icons.shopping_cart_outlined),
        const SizedBox(width: 10),
        const CircleAvatar(radius: 15),
        const SizedBox(width: 16),
      ],
    );
  }
}