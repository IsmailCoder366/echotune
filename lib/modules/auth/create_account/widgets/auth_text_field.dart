import 'package:flutter/material.dart';

class CreateAccountAuthTextField extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final TextEditingController? controller; // Added this

  const CreateAccountAuthTextField({
    super.key,
    required this.hint,
    this.isPassword = false,
    this.controller, // Added this
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Linked here
      obscureText: isPassword,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0XFF9D9C9C), fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}