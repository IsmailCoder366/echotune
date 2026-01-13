import 'package:flutter/material.dart';

class ProfileMenuTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ProfileMenuTile({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF4A4A4A),
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
          onTap: onTap,
        ),
        const Divider(height: 1, color: Color(0xFFEEEEEE)),
      ],
    );
  }
}