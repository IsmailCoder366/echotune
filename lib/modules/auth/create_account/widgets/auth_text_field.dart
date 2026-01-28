import 'package:flutter/material.dart';

class CreateAccountAuthTextField extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final bool obscureText; // Added
  final VoidCallback? onSuffixIconTap; // Added
  final TextEditingController? controller;

  const CreateAccountAuthTextField({
    super.key,
    required this.hint,
    this.isPassword = false,
    this.obscureText = false, // Added
    this.onSuffixIconTap, // Added
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      // If it's a password, use the obscureText value, otherwise false
      obscureText: isPassword ? obscureText : false,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0XFF9D9C9C), fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        filled: true,
        fillColor: Colors.white,

        // Suffix icon logic
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: const Color(0XFF9D9C9C),
            size: 20,
          ),
          onPressed: onSuffixIconTap,
        )
            : null,

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