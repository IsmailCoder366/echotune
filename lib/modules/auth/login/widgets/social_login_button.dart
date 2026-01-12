import 'package:flutter/material.dart';

class SocialAuthButton extends StatelessWidget {
  final String text;
  final String image;
  final VoidCallback onTap;

  const SocialAuthButton({
    super.key,
    required this.text,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
                height: 20,
                width: 20,
                image: AssetImage(image)),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}