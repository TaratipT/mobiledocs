// File: lib/widgets/song_card.dart
import 'package:flutter/material.dart';
import '../models/song_model.dart';

class SongCard extends StatelessWidget {
  final Song song;
  final VoidCallback onTap;

  const SongCard({super.key, required this.song, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(song.albumArtUrl), // ใช้ NetworkImage สำหรับตัวอย่าง
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            song.title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            song.artist,
            style: TextStyle(color: Colors.grey[400], fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}