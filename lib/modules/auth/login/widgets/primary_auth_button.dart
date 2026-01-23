import 'package:flutter/material.dart';

import '../../../../common/constants/app_colors.dart';

class PrimaryAuthButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // Made nullable to handle disabled state
  final bool isLoading; // Added this
  final Color? backgroundColor;
  final Color textColor;

  const PrimaryAuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false, // Default to false
    this.backgroundColor,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        // If loading, onPressed is null which disables the button
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.authColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
        )
            : Text(
          text,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}