import 'package:flutter/material.dart';
import '../models/song_model.dart';
import '../widgets/song_card.dart';
import 'player_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 1. สร้าง "เพลงตัวแทน" (Dummy) ไว้กัน error (ไม่ต้องใช้ ?)
  Song currentSong = Song(
    title: "",
    artist: "",
    albumArtUrl: "",
    writtenBy: "",
    metadata: "",
    likes: "",
    comments: "",
  );

  // 2. สวิตช์เช็คว่ามีการเลือกเพลงหรือยัง
  bool isSongSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // --- ส่วน APP BAR (ของเดิมครบถ้วน) ---
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,

        // YT Music Logo
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: 4),
            const Text(
              "Music",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),

        // Search, Profile Actions
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 8.0),
            child: const CircleAvatar(
              backgroundColor: Colors.brown,
              radius: 14,
              child: Text(
                "T",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- 1. Filter Chips (แถบหมวดหมู่ - ของเดิม) ---
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                _buildChip("กระปรี้กระเปร่า"),
                _buildChip("ผ่อนคลาย"),
                _buildChip("รู้สึกดี"),
                _buildChip("ปาร์ตี้"),
                _buildChip("ออกกำลังกาย"),
              ],
            ),
          ),

          // --- 2. Grid รายชื่อเพลง (ของเดิม + เพิ่ม logic กดเลือกเพลง) ---
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: mockSongs.length,
              itemBuilder: (context, index) {
                final song = mockSongs[index];
                return SongCard(
                  song: song,
                  onTap: () {
                    // [ส่วนที่เพิ่ม] : อัปเดตเพลงปัจจุบันและเปิดสวิตช์
                    setState(() {
                      currentSong = song;
                      isSongSelected = true;
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerScreen(song: song),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // --- 3. Mini Player (ส่วนใหม่ที่เพิ่มเข้ามา) ---
          // เช็คสวิตช์ ถ้า isSongSelected เป็น true ให้แสดง
          if (isSongSelected == true) _buildMiniPlayer(),
        ],
      ),

      // --- Bottom Navigation Bar (ของเดิม) ---
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "หน้าแรก",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: "สำรวจ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music_outlined),
            label: "คลังเพลง",
          ),
        ],
      ),
    );
  }

  // Widget สร้าง Mini Player ตามรูปที่ต้องการ
  Widget _buildMiniPlayer() {
    return Container(
      color: const Color(0xFF212121), // สีเทาเข้มเกือบดำ
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          // รูปปก
          ClipRRect(
            borderRadius: BorderRadius.circular(
              2,
            ), // ขอบมนนิดหน่อยตามสไตล์ YT Music
            child: Image.network(
              currentSong.albumArtUrl, // ใช้ข้อมูลจากตัวแปร dummy ได้เลย
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          // ชื่อเพลงและศิลปิน
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentSong.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  currentSong.artist,
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // ปุ่ม Cast และ Play
          IconButton(
            icon: const Icon(Icons.cast, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.play_arrow, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // Widget Filter Chips (ของเดิม)
  Widget _buildChip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}
