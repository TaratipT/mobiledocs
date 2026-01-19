// File: lib/models/song_model.dart

class Song {
  final String title;
  final String artist;
  final String albumArtUrl; // ใช้ URL หรือ path ของ asset
  final String writtenBy;
  final String metadata;
  final String likes; 
  final String comments;

  Song({
    required this.title,
    required this.artist,
    required this.albumArtUrl,
    required this.writtenBy,
    required this.metadata,
    required this.likes,
    required this.comments,
  });
}

// ข้อมูลตัวอย่าง (Mock Data) - เปลี่ยนเพลงใหม่เพื่อให้รูปขึ้นแน่นอน 100%
final List<Song> mockSongs = [
  Song(
    title: "Starboy",
    artist: "The Weeknd",
    albumArtUrl: "https://upload.wikimedia.org/wikipedia/en/3/39/The_Weeknd_-_Starboy.png",
    writtenBy: "Abel Tesfaye, DaHeala, Doc McKinney",
    metadata: "Starboy · 2016",
    likes: "2 แสน",
    comments: "339",
  ),
  Song(
    title: "Circles",
    artist: "Post Malone",
    albumArtUrl: "https://www.educatepark.com/wp-content/uploads/2019/09/Webp.net-resizeimage-32.jpg",
    writtenBy: "Austin Post, Louis Bell, Frank Dukes",
    metadata: "Hollywood's Bleeding · 2019",
    likes: "1.5 แสน",
    comments: "210",
  ),
  Song(
    title: "Bad Guy",
    artist: "Billie Eilish",
    albumArtUrl: "https://upload.wikimedia.org/wikipedia/en/3/33/Billie_Eilish_-_Bad_Guy.png",
    writtenBy: "Billie Eilish, Finneas O'Connell",
    metadata: "When We All Fall Asleep · 2019",
    likes: "3 แสน",
    comments: "450",
  ),
  Song(
    title: "Levitating",
    artist: "Dua Lipa",
    albumArtUrl: "https://i1.sndcdn.com/artworks-YL3ua1FAzIzzSk0e-OWj0qw-t1080x1080.jpg",
    writtenBy: "Dua Lipa, Clarence Coffee Jr., Stephen Kozmeniuk",
    metadata: "Future Nostalgia · 2020",
    likes: "1.8 แสน",
    comments: "275",
  ),
];