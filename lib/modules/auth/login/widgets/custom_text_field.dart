import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final bool obscureText; // Added
  final VoidCallback? onSuffixIconTap; // Added
  final TextEditingController? controller;

  const AuthTextField({
    super.key,
    required this.hint,
    this.controller,
    this.isPassword = false,
    this.obscureText = false, // Added
    this.onSuffixIconTap, // Added
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? obscureText : false,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

        // NEW: Suffix Icon for Password Toggle
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: Colors.grey,
            size: 20,
          ),
          onPressed: onSuffixIconTap,
        )
            : null,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
        ),
      ),
    );
  }
}