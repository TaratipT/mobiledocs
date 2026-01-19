import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ComparisonPage(),
  ));
}

class ComparisonPage extends StatelessWidget {
  const ComparisonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stateless vs Stateful")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ---------------------------------------------
            // 1. เรียกใช้ Stateless Widget
            // ---------------------------------------------
            const MyStatelessBox(text: "ผมคือ Stateless\n(นิ่งๆ เปลี่ยนค่าเองไม่ได้)"),
            
            const SizedBox(height: 20),
            const Divider(thickness: 2),
            const SizedBox(height: 20),

            // ---------------------------------------------
            // 2. เรียกใช้ Stateful Widget
            // ---------------------------------------------
            const MyStatefulCounter(),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 🔴 TYPE 1: STATELESS WIDGET
// (รับค่ามาโชว์ จบ. ไม่มีตัวแปรที่เปลี่ยนค่าได้)
// ==========================================
class MyStatelessBox extends StatelessWidget {
  final String text; // รับค่ามาแล้วเป็น final (ห้ามเปลี่ยน)

  const MyStatelessBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.grey[300],
      child: Column(
        children: [
          const Icon(Icons.lock, size: 40, color: Colors.grey),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 🟢 TYPE 2: STATEFUL WIDGET
// (มี State เก็บข้อมูล และสั่งเปลี่ยนหน้าจอได้)
// ==========================================
class MyStatefulCounter extends StatefulWidget {
  const MyStatefulCounter({super.key});

  @override
  State<MyStatefulCounter> createState() => _MyStatefulCounterState();
}

// คลาสลูก (State) เป็นที่เก็บตัวแปรที่เปลี่ยนแปลงได้
class _MyStatefulCounterState extends State<MyStatefulCounter> {
  int _counter = 0; // ตัวแปรนี้เปลี่ยนค่าได้!

  void _incrementCounter() {
    // ★ หัวใจสำคัญ: setState()
    // บอก Flutter ว่า "ข้อมูลเปลี่ยนแล้วนะ ช่วยวาดหน้าจอใหม่ที"
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.green[100],
      child: Column(
        children: [
          const Icon(Icons.touch_app, size: 40, color: Colors.green),
          const Text(
            "ผมคือ Stateful\n(กดปุ่มแล้วเลขจะเปลี่ยน)",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          
          Text(
            "$_counter", // เอาตัวแปรมาโชว์
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          
          ElevatedButton(
            onPressed: _incrementCounter, // กดแล้วไปเรียกฟังก์ชันเพิ่มเลข
            child: const Text("กดเพื่อเพิ่มเลข (+1)"),
          )
        ],
      ),
    );
  }
}