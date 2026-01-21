import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/upload_list_controller.dart';

class UploadListView extends StatelessWidget {
  const UploadListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadListController());

    return Column(
      children: [
        // Title and Search Icon
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Upload List",
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
              Expanded(flex: 4, child: Text("Affiliate link", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500))),
            ],
          ),
        ),

        // Uploaded Items List
        Expanded(
          child: Obx(() => ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.uploads.length,
            itemBuilder: (context, index) {
              final item = controller.uploads[index];
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
                    // Type Column
                    Expanded(
                      flex: 2,
                      child: Text(item['type']!, style: const TextStyle(fontSize: 13)),
                    ),
                    // Song Name Column with Edit Icon
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Text(
                            item['name']!,
                            style: const TextStyle(fontSize: 13, decoration: TextDecoration.underline),
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.edit, size: 14, color: Colors.orange.shade300),
                        ],
                      ),
                    ),
                    // Affiliate Link Column
                    Expanded(
                      flex: 4,
                      child: Text(
                        item['link']!,
                        style: const TextStyle(fontSize: 12, color: Colors.black87),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
        ),
      ],
    );
  }
}