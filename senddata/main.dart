import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // import หน้าแรกเข้ามา

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // ปิดป้าย Debug มุมขวาบน
      title: 'Data Flow Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // ใช้ดีไซน์แบบใหม่
      ),
      home: const HomeScreen(), // เริ่มต้นที่หน้า Home
    );
  }
}