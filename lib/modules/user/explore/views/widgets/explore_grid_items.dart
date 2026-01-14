import 'package:flutter/material.dart';

class ExploreGridItem extends StatelessWidget {
  const ExploreGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: AssetImage('assets/images/ilbum1.jpg'), // Use your placeholder image
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.music_note, color: Colors.white, size: 12),
                SizedBox(width: 4),
                Text("15 music", style: TextStyle(color: Colors.white, fontSize: 10)),
              ],
            ),
            const SizedBox(height: 15),
            const Text("Lorem Ipsum Dolor", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            const Text("Top Album", style: TextStyle(color: Colors.white70, fontSize: 10)),
          ],
        ),
      ),
    );
  }
}