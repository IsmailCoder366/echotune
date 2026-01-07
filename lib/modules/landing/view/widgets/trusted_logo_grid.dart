import 'package:flutter/material.dart';

class TrustLogoGrid extends StatelessWidget {
  const TrustLogoGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Text(
            "Trusted by World Best Companies\nand Creative Professional",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: 2,
          children: [
            _LogoItem(icon: Icons.api), // Replace with Image.asset for logos
            _LogoItem(icon: Icons.play_circle_fill),
            _LogoItem(icon: Icons.podcasts),
            _LogoItem(icon: Icons.music_note),
            _LogoItem(icon: Icons.shopping_cart),
            _LogoItem(icon: Icons.apple),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _LogoItem extends StatelessWidget {
  final IconData icon;
  const _LogoItem({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200, width: 0.5),
      ),
      child: Icon(icon, color: Colors.grey, size: 30),
    );
  }
}