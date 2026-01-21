// Reusable Bottom Sheet
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentPriceNoteBottomSheet extends StatelessWidget {
  const ContentPriceNoteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_outline, color: Colors.blue),
              const SizedBox(width: 10),
              const Expanded(
                child: Text("Note", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close)),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Any heading without pricing will not be displayed to your customer",
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}