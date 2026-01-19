import 'package:flutter/material.dart';
import '../models/song_model.dart';

class DetailsScreen extends StatelessWidget {
  final Song song;

  const DetailsScreen({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(song.artist, style: const TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // รูปใหญ่ด้านบน
            Center(
              child: Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(song.albumArtUrl),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {
                      // กัน Error
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            // ชื่อเพลง
            Text(
              "${song.title}", 
              style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // รายละเอียด
            _buildDetailRow("ศิลปิน", song.artist),
            const SizedBox(height: 15),
            _buildDetailRow("เขียนโดย", song.writtenBy),
            const SizedBox(height: 15),
            _buildDetailRow("ข้อมูลเมตาของเพลงจัดทำโดย", song.metadata),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.grey[500], fontSize: 14)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 16)),
      ],
    );
  }
}