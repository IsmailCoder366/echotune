import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../creator_dashboard/view/creator_dashboard_view.dart';
import '../../statement/view/statement_view.dart';
import '../controller/creator_main_controller.dart';


class CreatorMainScreen extends StatelessWidget {
  const CreatorMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the navigation controller
    final controller = Get.put(CreatorMainController());

    final List<Widget> pages = [
      AdminDashboardView(),
      StatementView(),

      const Center(child: Text("Upload List Screen")),
      const Center(child: Text("Complaint Screen")),
    ];

    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: pages,
      )),
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          selectedItemColor: const Color(0xFFE5B25D),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Statement"),
            BottomNavigationBarItem(icon: Icon(Icons.cloud_upload), label: "Upload list"),
            BottomNavigationBarItem(icon: Icon(Icons.error_outline), label: "Complaint"),
          ],
        ),
      ),
    );
  }
}