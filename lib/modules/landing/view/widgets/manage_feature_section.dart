import 'package:flutter/material.dart';

class ManagementFeatureSection extends StatelessWidget {
  const ManagementFeatureSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A1A1A),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Manage All Your Music at One Place",
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _FeatureAccordion(title: "Feature 1", isActive: true),
          _FeatureAccordion(title: "Feature 2"),
          _FeatureAccordion(title: "Feature 3"),
        ],
      ),
    );
  }
}

class _FeatureAccordion extends StatelessWidget {
  final String title;
  final bool isActive;
  const _FeatureAccordion({required this.title, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.3))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
          const Icon(Icons.add, color: Colors.white, size: 18),
        ],
      ),
    );
  }
}