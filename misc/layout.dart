import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LayoutVisualizerPage(),
  ));
}

class LayoutVisualizerPage extends StatelessWidget {
  const LayoutVisualizerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text("Layout X-Ray Mode")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: _buildXRayCard(),
        ),
      ),
    );
  }

  Widget _buildXRayCard() {
    // 1. กรอบใหญ่สุด (Container)
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2), // ขอบดำหนาๆ ให้รู้ว่าเป็นกรอบแม่
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // ให้หดขนาดเท่าเนื้อหาข้างใน
        crossAxisAlignment: CrossAxisAlignment.stretch, // ยืดลูกให้เต็มความกว้าง
        children: [
          
          // --- HEADER: บอกว่าเป็น Column ---
          Container(
            color: Colors.black12,
            padding: const EdgeInsets.all(4),
            child: const Text("🔻 Parent Widget: Column (เรียงแนวตั้ง)", 
              style: TextStyle(fontWeight: FontWeight.bold)),
          ),

          // --- ส่วนที่ 1: Stack ---
          Container(
            height: 150,
            color: Colors.blue[100], // สีฟ้า = พื้นที่ Stack
            padding: const EdgeInsets.all(8),
            child: Stack(
              children: [
                // Layer ล่างสุด
                const Center(
                  child: Text("🟦 Stack (Base Layer)\n(วาง Image ตรงนี้)", 
                    textAlign: TextAlign.center),
                ),
                
                // Layer บน (Positioned)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    color: Colors.redAccent, // สีแดง = ของที่ลอยอยู่
                    padding: const EdgeInsets.all(8),
                    child: const Text("🔴 Positioned\n(top: 10, right: 10)", 
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
              ],
            ),
          ),

          const Divider(thickness: 2, color: Colors.black), // เส้นคั่นแบ่งส่วน

          // --- ส่วนที่ 2: Padding & Content ---
          Container(
            color: Colors.green[50], // สีเขียวอ่อน = พื้นที่ Padding
            padding: const EdgeInsets.all(20), // ดันเนื้อหาเข้าข้างใน 20
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("🟩 Widget: Padding (all: 20)", 
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                
                const SizedBox(height: 10),

                // ลูกของ Padding ก็เป็น Column อีกที
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green), // ขอบเขียว
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("🔻 Inner Column (เรียงเนื้อหา)", style: TextStyle(fontWeight: FontWeight.bold)),
                      
                      const SizedBox(height: 10),
                      // Text ธรรมดา
                      Container(
                        color: Colors.orange[100],
                        padding: const EdgeInsets.all(4),
                        width: double.infinity,
                        child: const Text("📝 Widget: Text ('Title')"),
                      ),
                      
                      const SizedBox(height: 10),
                      
                      // --- Row แบบชิดซ้าย (Default) ---
                      Container(
                        color: Colors.purple[100], // สีม่วง = พื้นที่ Row
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            const Text("➡ Row : "),
                            const SizedBox(width: 5),
                            Container(color: Colors.purple, width: 20, height: 20), // สมมติเป็นไอคอน
                            const SizedBox(width: 5),
                            const Text("[Icon]"),
                            const SizedBox(width: 10),
                            const Text("[Text]"),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 10),

                      // --- Row แบบแยกฝั่ง (SpaceBetween) ---
                      Container(
                        color: Colors.pink[100], // สีชมพู = พื้นที่ Row
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // หัวใจสำคัญ
                          children: [
                            const Text("➡ Row (SpaceBetween)"),
                            
                            // ฝั่งซ้าย
                            Container(
                              color: Colors.teal[100],
                              child: const Text("[Price]"),
                            ),
                            
                            // ฝั่งขวา
                            Container(
                              color: Colors.teal[300],
                              child: const Text("[Button]"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}