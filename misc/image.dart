import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ImagePracticePage(),
  ));
}

class ImagePracticePage extends StatelessWidget {
  const ImagePracticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Loading Practice")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          
          // --- CASE 1: ดึงออกแบบปกติ (Basic) ---
          _buildHeader("1. ดึงออกแบบปกติ (Basic)"),
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey[200],
            child: Image.network(
              'https://picsum.photos/id/237/400/200', // รูปน้องหมา
              fit: BoxFit.cover, // ★ สำคัญ: ขยายรูปให้เต็มพื้นที่ (ลองเปลี่ยนเป็น contain ดูความต่าง)
            ),
          ),
          const SizedBox(height: 20),


          // --- CASE 2: ใส่ Loading (ระหว่างรอรูปมา) ---
          _buildHeader("2. ใส่ตัวหมุนๆ ระหว่างรอโหลด (LoadingBuilder)"),
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey[100],
            child: Image.network(
              'https://picsum.photos/id/10/800/800', // รูปความละเอียดสูง (เพื่อให้โหลดนานนิดนึง)
              fit: BoxFit.cover,
              
              // ส่วนนี้ทำงานตอนกำลังโหลด
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child; // ถ้าโหลดเสร็จแล้ว ให้โชว์รูป (child)
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                      const SizedBox(height: 10),
                      Text("กำลังโหลด... ${(loadingProgress.cumulativeBytesLoaded / 1024).toStringAsFixed(0)} KB"),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),


          // --- CASE 3: จัดการลิงก์เสีย (ErrorBuilder) ---
          _buildHeader("3. จัดการเมื่อลิงก์เสีย/เน็ตหลุด (ErrorBuilder)"),
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.red[50], // พื้นหลังแดงอ่อนๆ เตือนว่ามีปัญหา
            child: Image.network(
              'https://bad-link-example.com/no-image.jpg', // ลิงก์มั่ว ไม่มีจริง
              fit: BoxFit.cover,
              
              // ส่วนนี้ทำงานเมื่อหาภาพไม่เจอ
              errorBuilder: (context, error, stackTrace) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.broken_image, size: 50, color: Colors.grey),
                    Text("ไม่สามารถโหลดรูปภาพได้", style: TextStyle(color: Colors.grey)),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 20),


          // --- CASE 4: รูปวงกลม (Profile Style) ---
          _buildHeader("4. ดึงรูปมาทำโปรไฟล์วงกลม (CircleAvatar)"),
          const Center(
            child: CircleAvatar(
              radius: 60, // ขนาดวงกลม
              backgroundColor: Colors.teal,
              backgroundImage: NetworkImage('https://picsum.photos/id/64/200/200'),
            ),
          ),
           const SizedBox(height: 20),

           
           // --- CASE 5: ตกแต่งขอบมน + เงา (DecorationImage) ---
           _buildHeader("5. รูปใน Container (DecorationImage)"),
           Container(
             height: 200,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20), // ขอบมน
               boxShadow: const [BoxShadow(blurRadius: 10, color: Colors.black26)], // เงา
               image: const DecorationImage(
                 image: NetworkImage('https://picsum.photos/id/28/400/200'),
                 fit: BoxFit.cover, // ขยายเต็มกรอบ
               )
             ),
             // ข้อดีของแบบนี้คือ ใส่ child ทับบนรูปได้เลย
             child: const Center(
               child: Text("ข้อความบนรูป", 
                 style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, shadows: [Shadow(blurRadius: 10, color: Colors.black)])),
             ),
           ),
           const SizedBox(height: 40),

          // ---------------------------------------------------
          // ★ 6. LOCAL ASSET (ดึงจากเครื่อง) ★
          // ---------------------------------------------------
          // assets:
          // - assets/images/
          _buildHeader("★ 4. Local Asset (ดึงจากไฟล์ในเครื่อง)"),
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent), // ตีกรอบให้รู้ว่าเป็น Local
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect( // ตัดมุมโค้งให้รูป
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/sanctuaryjoji.jpg', // ⚠️ ต้องมีไฟล์นี้จริงในโปรเจกต์
                fit: BoxFit.cover,
                // ถ้ายังไม่ได้ลงไฟล์ จะขึ้นกากบาทแดงตรงนี้
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text("⚠️ อย่าลืมสร้างไฟล์และแก้ pubspec.yaml\n(ดูวิธีด้านล่าง)", 
                    textAlign: TextAlign.center, style: TextStyle(color: Colors.red)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // Widget ช่วยสร้างหัวข้อเฉยๆ
  Widget _buildHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}