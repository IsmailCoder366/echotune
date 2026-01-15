import 'package:flutter/material.dart';

class ActionUploadCard extends StatelessWidget {
  final String title;
  final Color bgColor;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onUpload;

  const ActionUploadCard({
    required this.title,
    required this.bgColor,
    required this.icon,
    required this.iconColor,
    required this.onUpload
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.2),
            child: Icon(icon, color: iconColor),
          ),
          SizedBox(height: 12),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text("Lorem ipsum dolor sit amet\nconsectetur.", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onUpload,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1A1A1A),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
              ),
              child: Text("Upload", style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}