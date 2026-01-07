import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF121212),
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          const Text("ECHOTUNE",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: _footerLinks.map((link) => Text(link,
                style: const TextStyle(color: Colors.grey, fontSize: 12))).toList(),
          ),
          const SizedBox(height: 30),
          TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Search Songs",
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white.withOpacity(0.1),
              suffixIcon: const Icon(Icons.search, color: Color(0xFFEAB308)),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 30),
          const Divider(color: Colors.grey),
          const Text(
            "Copyright © 2023. All Rights Reserved.",
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ],
      ),
    );
  }

  static const _footerLinks = ["Register", "Request", "Login", "About us", "Contact", "Others"];
}