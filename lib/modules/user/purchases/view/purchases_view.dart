import 'package:echotune/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/purchases_controller.dart';

class PurchasesView extends StatelessWidget {
  final PurchasesController controller = Get.put(PurchasesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading:  Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(

            children: [
              Padding(padding: EdgeInsetsGeometry.only(top: 10, left: 5)),
              Text("ECHOTUNE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
              Text("YOUR SOUND, YOUR WORLD", style: TextStyle(color: Colors.white, fontSize: 8)),

            ],
          ),
        ),
        leadingWidth: 140,
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
      body: Column(
        children: [
          _buildTabBarHeader(),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                _buildPurchasesList(), // Tab 0
                // _buildEmptyState('not yet purchached'),// Tab 0
                _buildFavouritesList(), // Tab 1
                _buildUserInfoBody(),   // Tab 2
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- TAB BAR HEADER ---
  Widget _buildTabBarHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
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

  // --- TAB 0: PURCHASES BODY ---
  Widget _buildPurchasesList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("List of Purchases", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                  child: const Icon(Icons.search, size: 28)),
            ],
          ),
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

  // --- TAB 1: FAVOURITES BODY ---
  Widget _buildFavouritesList() {
    return Obx(() {
      if (controller.favoriteItems.isEmpty) {
        // Wrap empty state in Center and Expanded to fill space
        return Center(child: _buildEmptyState("No Favourites Yet"));
      } else {
        // Wrap ListView in Padding for consistent spacing
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("List of Purchases", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Colors.black
                          )
                      ),
                      child: const Icon(Icons.search, size: 28)),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  itemCount: controller.favoriteItems.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) => _buildMusicTile(
                    controller.favoriteItems[index],
                    isFav: true,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }


  // --- TAB 2: USER INFO BODY ---
  Widget _buildUserInfoBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/image.png'),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: .start,
                crossAxisAlignment: .start,
                children: [
                  Text('Profile Picture', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  SizedBox(height: 5),
                  Text('Recommended memory size is less than 12MB', style: TextStyle(fontSize: 10)),
                  SizedBox(height: 10),
                  Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(onPressed: (){}, child: Text('Upload', style: TextStyle(color: Colors.white),)),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 10),
          Text('Name'),
          SizedBox(height: 5),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter Name',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black
                )
              ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.black
                    )
                )
            ),
          ),
          SizedBox(height: 10),
          Text('Email'),
          SizedBox(height: 5),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Enter Email',
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.black
                    )
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.black
                    )
                )
            ),
          ),
          SizedBox(height: 20),
          Text('Change Password', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          SizedBox(height: 10),
          Text('Old Password'),
          SizedBox(height: 5),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Enter Old Password',
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.black
                    )
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.black
                    )
                )
            ),
          ),
          SizedBox(height: 10),
          Text('New Password'),
          SizedBox(height: 5),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Enter New Password',
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.black
                    )
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.black
                    )
                )
            ),
          ),
          SizedBox(height: 10),
          Text('Confirm Password'),
          SizedBox(height: 5),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Enter Confrim Password',
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.black
                    )
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.black
                    )
                )
            ),
          ),
          SizedBox(height: 20),
          Text('Bank Account', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text('Account Number'),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Enter Account',
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.black
                    )
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.black
                    )
                )
            ),
          ),
          SizedBox(height: 5),
          Text('IFSC Code'),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Enter IFSC Number',
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.black
                    )
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.black
                    )
                )
            ),
          ),
        ],
      ),
    );
  }

  // --- REUSABLE COMPONENTS ---
  Widget _buildMusicTile(String title, {bool isFav = false}) {
    return ListTile(

      leading: const Icon(Icons.play_circle_outline, size: 40, color: Colors.black87),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: const Text("by Lorem", style: TextStyle(color: Colors.grey, fontSize: 10)),

      trailing: isFav
          ? Row(
        mainAxisSize: MainAxisSize.min, // <-- Important: take minimal space
        children: [
          const Icon(Icons.favorite, color: Colors.black),
          const SizedBox(width: 10),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(Icons.shopping_cart, color: AppColors.primaryColor),
          ),
        ],
      )
          : null,
    );
  }


  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String msg) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(msg, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE5B25D)),
          child: const Text("Explore More", style: TextStyle(color: Colors.black)),
        )
      ],
    );
  }

}