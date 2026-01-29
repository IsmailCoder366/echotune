import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../profile/bottom_view/bottom_sheet_view.dart';
import '../../purchases/controllers/user_info_controller.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/features_section.dart';
import '../widgets/header_section.dart';


class UserHomeScreen extends StatelessWidget {

  final UserInfoController userInfoController = Get.put(UserInfoController());


   UserHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Key property for hero backgrounds
      appBar:  CustomHomeAppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeroHeader(),
            const FeaturedSection(),
          ],
        )
      ),
      // Persistent Bottom Handle as requested
      bottomNavigationBar: GestureDetector(
        onTap: () => showProfileBottomSheet(),
        child: Container(
          height: 30,
          color: Colors.white,
          child: Center(
            child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          ),
        ),
      ),
    );
  }
}