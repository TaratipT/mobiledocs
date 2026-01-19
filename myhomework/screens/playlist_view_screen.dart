// File: lib/screens/playlist_view_screen.dart
import 'package:flutter/material.dart';
import 'create_playlist_screen.dart';

// Class สำหรับเก็บข้อมูล Playlist
class PlaylistData {
  final String title;
  final String description;
  final String privacy;

  PlaylistData({
    required this.title,
    required this.description,
    required this.privacy,
  });
}

class PlaylistViewScreen extends StatefulWidget {
  const PlaylistViewScreen({super.key});

  @override
  State<PlaylistViewScreen> createState() => _PlaylistViewScreenState();
}

class _PlaylistViewScreenState extends State<PlaylistViewScreen> {
  // ข้อมูลเพลย์ลิสต์
  List<PlaylistData> myPlaylists = [];

  // ฟังก์ชันไปหน้าสร้าง
  void _goToCreatePlaylist() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreatePlaylistScreen()),
    );

    if (result != null && result is PlaylistData) {
      setState(() {
        myPlaylists.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("คลังเพลย์ลิสต์", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      
      // ส่วนเนื้อหาแสดงรายการ
      body: myPlaylists.isEmpty
          ? Center(
              child: Text(
                "ยังไม่มีเพลย์ลิสต์",
                style: TextStyle(color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 10, bottom: 80), // เผื่อที่ให้ปุ่มด้านล่าง
              itemCount: myPlaylists.length,
              itemBuilder: (context, index) {
                final playlist = myPlaylists[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[850], // สีเทาเปล่าๆ
                      borderRadius: BorderRadius.circular(4),
                    ),
                    // ไม่ใส่ child (Text) ตามที่ขอครับ
                  ),
                  title: Text(playlist.title, style: const TextStyle(color: Colors.white)),
                  subtitle: Text(
                    "${playlist.privacy} • ${playlist.description}",
                    style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    onPressed: () {},
                  ),
                );
              },
            ),

      // ปุ่ม "+ ใหม่" มุมขวาล่าง
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToCreatePlaylist,
        backgroundColor: Colors.white, // สีพื้นหลังปุ่ม
        label: const Text(
          "+ ใหม่",
          style: TextStyle(
            color: Colors.black, // สีตัวหนังสือ
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}