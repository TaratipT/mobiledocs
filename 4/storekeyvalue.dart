// flutter pub add shared_preferences

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Prefs Tester',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SharedPrefsTester(),
    );
  }
}

class SharedPrefsTester extends StatefulWidget {
  const SharedPrefsTester({super.key});

  @override
  State<SharedPrefsTester> createState() => _SharedPrefsTesterState();
}

class _SharedPrefsTesterState extends State<SharedPrefsTester> {
  // ตัวควบคุม TextField
  final TextEditingController _controller = TextEditingController();
  
  // ตัวแปรสำหรับแสดงผลข้อมูลที่โหลดมา
  String _savedData = "ยังไม่มีข้อมูล";

  @override
  void initState() {
    super.initState();
    // โหลดข้อมูลทันทีเมื่อเริ่มแอป
    _loadData();
  }

  // ฟังก์ชัน 1: บันทึกข้อมูล (Save)
  Future<void> _saveData() async {
    if (_controller.text.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    // บันทึก String ลงไปที่ key ชื่อ 'user_text'
    await prefs.setString('user_text', _controller.text);

    // อัปเดต UI และเคลียร์ช่องกรอก
    setState(() {
      _savedData = _controller.text;
    });
    _controller.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('บันทึกข้อมูลเรียบร้อย!')),
    );
  }

  // ฟังก์ชัน 2: โหลดข้อมูล (Read)
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // อ่านค่าจาก key 'user_text' ถ้าไม่มีให้คืนค่า default
      _savedData = prefs.getString('user_text') ?? "ไม่พบข้อมูลที่บันทึกไว้";
    });
  }

  // ฟังก์ชัน 3: ลบข้อมูล (Remove)
  Future<void> _removeData() async {
    final prefs = await SharedPreferences.getInstance();
    // ลบ key 'user_text' ทิ้ง
    await prefs.remove('user_text');

    setState(() {
      _savedData = "ลบข้อมูลแล้ว";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('ลบข้อมูลเรียบร้อย!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ทดสอบ Shared Preferences')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ส่วนแสดงผล
            const Text('ข้อมูลที่บันทึกอยู่ในเครื่อง:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text(
              _savedData,
              style: const TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
                color: Colors.blue
              ),
              textAlign: TextAlign.center,
            ),
            const Divider(height: 40, thickness: 2),

            // ส่วนกรอกข้อมูล
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'กรอกข้อความที่ต้องการบันทึก',
                hintText: 'พิมพ์อะไรก็ได้ที่นี่...',
              ),
            ),
            const SizedBox(height: 20),

            // ปุ่มกดต่าง ๆ
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ปุ่ม Save
                ElevatedButton.icon(
                  onPressed: _saveData,
                  icon: const Icon(Icons.save),
                  label: const Text('บันทึก'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                ),
                
                // ปุ่ม Load (เอาไว้กดเพื่อรีเฟรชดูค่า)
                ElevatedButton.icon(
                  onPressed: _loadData,
                  icon: const Icon(Icons.refresh),
                  label: const Text('โหลด'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            
            // ปุ่ม Remove
            TextButton.icon(
              onPressed: _removeData,
              icon: const Icon(Icons.delete, color: Colors.red),
              label: const Text('ลบข้อมูลทิ้ง', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/screens/todo_screen.dart';
// import 'package:flutter_application_1/screens/add_todo_screen.dart';

// void main() {
//   runApp(MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'TodoList',
//       theme: ThemeData(primarySwatch: Colors.red),
//       home: HomeScreen(),
//     );
//   }
// }