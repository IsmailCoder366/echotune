import 'package:flutter/material.dart';

class MusicListTile extends StatelessWidget {
  final String title;
  final String artist;
  final String imageUrl; // Added this
  final VoidCallback onPlayTap;
  final bool isFavorite;

  const MusicListTile({
    super.key,
    required this.title,
    required this.artist,
    required this.imageUrl, // Pass this from the list
    required this.onPlayTap,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: onPlayTap,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network( // Use network for dynamic URLs
                    imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: Colors.grey, width: 50, height: 50),
                  ),
                ),
                const CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.black38,
                  child: Icon(Icons.play_arrow, color: Colors.white, size: 16),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(artist, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Icon(isFavorite ? Icons.favorite : Icons.favorite_border, size: 22),
          const SizedBox(width: 15),
          _buildCartIcon(),
        ],
      ),
    );
  }

  Widget _buildCartIcon() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFE5B25D), width: 1.5),
      ),
      child: const Icon(Icons.shopping_cart_outlined, color: Color(0xFFE5B25D), size: 18),
    );
  }
}