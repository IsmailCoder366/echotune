import 'package:flutter/material.dart';
// Import your view files here
// import 'package:your_app/music_upload_view.dart';
// import 'package:your_app/content_upload_view.dart';

Widget buildActionCard({
  required String title,
  required Color bgColor,
  required IconData icon,
  required Color iconColor,
  required VoidCallback onUploadPressed, // Added callback parameter
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        // Pass the callback to your custom button
        UploadButton(ontap: onUploadPressed)
      ],
    ),
  );
}

class UploadButton extends StatelessWidget {
  const UploadButton({super.key, required this.ontap}); // Added const

  final VoidCallback ontap; // Marked as final for best practice

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: ontap,
      style: TextButton.styleFrom(padding: EdgeInsets.zero), // Remove default padding
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text('Upload', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}