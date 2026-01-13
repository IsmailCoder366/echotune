import 'package:flutter/material.dart';

class PurchaseItemTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const PurchaseItemTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            height: 28,
            width: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black),
            ),
            child: const Icon(Icons.play_arrow, size: 18),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
