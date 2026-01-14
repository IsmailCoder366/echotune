import 'package:flutter/material.dart';

class TrustLogoGrid extends StatelessWidget {
  const TrustLogoGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Text(
            "Trusted by World Best Companies\nand Creative Professional",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: 2,
          crossAxisSpacing: 12,   // horizontal gap
          mainAxisSpacing: 12,
          padding: EdgeInsets.all(15),
          children: [
            _LogoItem(image:'assets/trusted_logos/JioSaavn.png'), // Replace with Image.asset for logos
            _LogoItem(image:'assets/trusted_logos/Amazon Music.png'), // Replace with Image.asset for logos
            _LogoItem(image:'assets/trusted_logos/Apple-Logo.png'), // Replace with Image.asset for logos
            _LogoItem(image:'assets/trusted_logos/Spotify.png'), // Replace with Image.asset for logos
            _LogoItem(image:'assets/trusted_logos/Wynk Music.png'), // Replace with Image.asset for logos
            _LogoItem(image:'assets/trusted_logos/Youtube.png'), // Replace with Image.asset for logos
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _LogoItem extends StatelessWidget {
  final String image;
  const _LogoItem({required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.asset(image);
  }
}