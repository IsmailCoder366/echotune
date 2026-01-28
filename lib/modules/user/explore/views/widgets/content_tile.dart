import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentTile extends StatelessWidget {
  final String title;
  final String artist;
  final String imageUrl; // Change this from asset to string URL
  final VoidCallback onPlayTap;
  final bool isFavorite;

  const ContentTile({
    super.key,
    required this.title,
    required this.artist,
    required this.imageUrl,
    required this.onPlayTap,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return
       Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            // 1. Thumbnail with Play Trigger
            GestureDetector(
              onTap: onPlayTap, // Opens the PlayingOverlay
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Play icon overlay as seen in design
                  const CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.black38,
                    child: Icon(Icons.play_arrow, color: Colors.white, size: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),

            // 2. Track Metadata
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    artist,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),

            // 3. Action Icons
            // Heart icon (Filled or Bordered based on state)
            Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.black,
              size: 22,
            ),
            const SizedBox(width: 15),

            // Gold Circular Cart Icon
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE5B25D), width: 1.5),
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: Color(0xFFE5B25D),
                size: 18,
              ),
            ),
          ],
        ),
    );
  }
}