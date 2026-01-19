// File: lib/screens/player_screen.dart
import 'package:flutter/material.dart';
import '../models/song_model.dart';
import 'details_screen.dart';

class PlayerScreen extends StatelessWidget {
  final Song song;

  const PlayerScreen({super.key, required this.song});

  Widget _buildActionButton(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.transparent, 
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          if (text.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.cast, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(song: song),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 1. ส่วนของรูปภาพ
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 24.0),
                width: 350,
                height: 350,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    song.albumArtUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                       return Container(color: Colors.grey, child: const Icon(Icons.music_note, size: 50));
                    },
                  ),
                ),
              ),
            ),

            // 2. ส่วนของชื่อเพลงและศิลปิน
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    song.artist,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 3. ปุ่ม Action
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(Icons.thumb_up, song.likes), // ดึงค่า likes
                  _buildActionButton(Icons.thumb_down, ''),
                  _buildActionButton(Icons.comment, song.comments), // ดึงค่า comments
                  _buildActionButton(Icons.bookmark, 'บันทึก'),
                ],
              ),
            ),
// ...
            const SizedBox(height: 30),

            // 4. Progress Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const LinearProgressIndicator(
                    value: 0.3,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('0:54', style: TextStyle(color: Colors.grey)),
                      Text('3:00', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 5. ปุ่มควบคุม
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shuffle, color: Colors.grey, size: 30),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_previous, color: Colors.white, size: 40),
                    onPressed: () {},
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.play_arrow, color: Colors.black, size: 40),
                      onPressed: () {},
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_next, color: Colors.white, size: 40),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.repeat, color: Colors.white, size: 30),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // 6. ข้อความด้านล่าง
            Center(
              child: Text(
                'สถานีวิทยุ ${song.title}',
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}