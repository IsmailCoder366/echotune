import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/complain_controller.dart';

class ComplainView extends StatelessWidget {
  const ComplainView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(ComplainController());

    return Scaffold(
      body: Column(
        children: [
          // Title and Search Icon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Privacy Complaints",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.grey),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Grey Table Header
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: const BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: const Row(
              children: [
                Expanded(flex: 2, child: Text("Type", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500))),
                Expanded(flex: 3, child: Text("Song name", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500))),
                Expanded(flex: 4, child: Text("Date & Time", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500))),
              ],
            ),
          ),

          // Complaints List
          Expanded(
            child: Obx(() {
              // Check if list is empty to avoid Obx error if there's no data
              if (controller.complaints.isEmpty) {
                return const Center(child: Text("No complaints found"));
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.complaints.length,
                itemBuilder: (context, index) {
                  final item = controller.complaints[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.grey.shade300),
                        right: BorderSide(color: Colors.grey.shade300),
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(item['type'] ?? "", style: const TextStyle(fontSize: 13)),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            item['name'] ?? "",
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            item['date_time'] ?? "",
                            style: const TextStyle(fontSize: 12, color: Colors.black87),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}