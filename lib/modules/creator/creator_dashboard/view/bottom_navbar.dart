import 'package:flutter/material.dart';

Widget buildBottomNav() {
  return BottomNavigationBar(
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
  );
}