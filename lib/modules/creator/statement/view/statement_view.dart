import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/statement_controller.dart';

class StatementView extends StatelessWidget {
  const StatementView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StatementController());

    return Column(
      children: [
        // Header Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Statement",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.search, color: Colors.grey),
                onPressed: () {},
              ),
            ],
          ),
        ),

        // Summary Cards Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildSummaryCard("Overall total", "\$${controller.overallTotal}", const Color(0xFFE7EEFF), true),
              const SizedBox(width: 8),
              _buildSummaryCard("Music", "\$${controller.musicTotal}", Colors.white, false),
              const SizedBox(width: 8),
              _buildSummaryCard("Content", "\$${controller.contentTotal}", Colors.white, false),
            ],
          ),
        ),

        const SizedBox(height: 25),

        // Table Header
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Expanded(flex: 2, child: Text("Date", style: TextStyle(color: Colors.grey))),
              Expanded(flex: 2, child: Text("Time", style: TextStyle(color: Colors.grey))),
              Expanded(flex: 3, child: Text("Customer name", style: TextStyle(color: Colors.grey))),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Transaction List
        Expanded(
          child: Obx(() => ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.transactions.length,
            itemBuilder: (context, index) {
              final item = controller.transactions[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text(item['date']!, style: const TextStyle(fontSize: 13))),
                    Expanded(flex: 2, child: Text(item['time']!, style: const TextStyle(fontSize: 13))),
                    Expanded(
                      flex: 3,
                      child: Text(
                        item['name']!,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
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

  Widget _buildSummaryCard(String title, String value, Color bgColor, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? Colors.blue.shade200 : Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
            const SizedBox(height: 6),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}