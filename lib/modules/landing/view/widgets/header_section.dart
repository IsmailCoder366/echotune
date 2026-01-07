import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class HeroHeader extends StatelessWidget {
  const HeroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    const double overlapOffset = 60.0;

    return Container(

      // This margin is the "Magic Fix".
      // It pushes the next widget down so it doesn't collide with the cards.
      margin: const EdgeInsets.only(bottom: overlapOffset + 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. BACKGROUND SECTION
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 80,
                bottom: overlapOffset + 20
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/colourfull_image.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Essential: only take up needed space
              children: [
                const Text(
                  "Lorem ipsum dolor sit amet consectetur",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: const Icon(Icons.search, color: Colors.orange),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. OVERLAPPING CARDS
          Positioned(
            bottom: -overlapOffset,
            left: 16,
            right: 16,
            child: IntrinsicHeight(
              child: Row(
                children: const [
                  Expanded(
                    child: _UserTypeCard(
                      title: "Music/Content",
                      subtitle: 'Creator',
                      icon: Icons.mic_external_on,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _UserTypeCard(
                      title: "Music/Content",
                      subtitle: 'User',
                      icon: Icons.person_outline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserTypeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _UserTypeCard({
    super.key,
    required this.title,
    required this.icon,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // NO FIXED WIDTH HERE - Expanded parent handles it
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.orange, size: 28),
          const SizedBox(height: 12),
          // We wrap text in Flexible to ensure it wraps rather than overflows
          Flexible(
            child: Text(
              "$title\n$subtitle",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}