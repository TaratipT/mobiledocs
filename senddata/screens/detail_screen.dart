import 'package:flutter/material.dart';
import '../models/user_item.dart';
import 'edit_screen.dart';

class DetailScreen extends StatefulWidget {
  final UserItem user; // รับค่ามาจาก Home

  const DetailScreen({super.key, required this.user});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late UserItem currentUser; // ตัวแปรสำหรับแสดงผลในหน้านี้ (เพื่อให้เปลี่ยนค่าได้)

  @override
  void initState() {
    super.initState();
    currentUser = widget.user; // เริ่มต้นด้วยค่าที่ส่งมา
  }

  // ฟังก์ชันสำหรับกดปุ่ม Back ที่มุมซ้ายบน
  void _onBackPressed() {
    // ส่งค่าล่าสุดกลับไปให้ Home
    Navigator.pop(context, currentUser);
  }

  @override
  Widget build(BuildContext context) {
    // PopScope ใช้ดักจับการกดปุ่ม Back ของ Android หรือปุ่ม Back ของ Browser
    return PopScope(
      canPop: false, // ปิดการ Back อัตโนมัติ เพื่อเราจะจัดการเอง
      onPopInvoked: (didPop) {
        if (didPop) return;
        _onBackPressed(); // เรียกฟังก์ชันส่งค่าคืน
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(currentUser.name), // ชื่อเปลี่ยนตาม State
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _onBackPressed, // กด Back ปุ๊บ ส่งค่าคืน
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                // 1. ไปหน้า Edit และรอรับค่าคืน (await)
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditScreen(user: currentUser),
                  ),
                );

                // 2. ถ้ามีค่าส่งกลับมา ให้ "เปลี่ยนค่า ณ หน้านั้น"
                if (result != null && result is UserItem) {
                  setState(() {
                    currentUser = result; // อัปเดต UI ทันที
                  });
                }
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person, size: 100, color: Colors.blue),
              const SizedBox(height: 20),
              Text("Name: ${currentUser.name}", style: const TextStyle(fontSize: 20)),
              Text("Email: ${currentUser.email}", style: const TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}