// flutter pub add path_provider

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

// 1. Class สำหรับจัดการการ อ่าน/เขียน ไฟล์ (Logic)
class CounterStorage {
  // หา Path ของ Documents directory ในเครื่อง
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // สร้าง Reference ไปยังไฟล์ counter.txt
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  // อ่านข้อมูลจากไฟล์
  Future<int> readCounter() async {
    try {
      final file = await _localFile;
      // อ่านเนื้อหาเป็น String
      final contents = await file.readAsString();
      // แปลงเป็น int ส่งกลับไป
      return int.parse(contents);
    } catch (e) {
      // ถ้าไม่มีไฟล์ หรือ error ให้คืนค่า 0
      return 0;
    }
  }

  // เขียนข้อมูลลงไฟล์
  Future<File> writeCounter(int counter) async {
    final file = await _localFile;
    // เขียนข้อมูลทับลงไปใหม่
    return file.writeAsString('$counter');
  }

  // ฟังก์ชันแถม: ลบไฟล์ทิ้ง (เพื่อทดสอบ Reset)
  Future<void> deleteFile() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // จัดการ Error ตามเหมาะสม
      print("Error deleting file: $e");
    }
  }
}

// 2. Class ส่วนแสดงผล (UI)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Read/Write Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      // ส่ง instance ของ CounterStorage เข้าไป
      home: FileIOTester(storage: CounterStorage()),
    );
  }
}

class FileIOTester extends StatefulWidget {
  const FileIOTester({super.key, required this.storage});

  final CounterStorage storage;

  @override
  State<FileIOTester> createState() => _FileIOTesterState();
}

class _FileIOTesterState extends State<FileIOTester> {
  int _counter = 0;
  String _filePath = "กำลังโหลด Path..."; // เอาไว้โชว์ที่อยู่ไฟล์

  @override
  void initState() {
    super.initState();
    // โหลดข้อมูลเมื่อเริ่มแอป
    widget.storage.readCounter().then((value) {
      setState(() {
        _counter = value;
      });
    });
    // แสดง Path ให้ดูหน่อยว่าไฟล์อยู่ไหน
    _showPath();
  }

  Future<void> _showPath() async {
    final file = await widget.storage._localFile; // เข้าถึงผ่าน getter (ในที่นี้ขออนุญาตเข้าถึงเพื่อโชว์ path)
    setState(() {
      _filePath = file.path;
    });
  }

  Future<File> _incrementCounter() {
    setState(() {
      _counter++;
    });
    // บันทึกลงไฟล์ทันทีที่ค่าเปลี่ยน
    return widget.storage.writeCounter(_counter);
  }

  Future<void> _resetCounter() async {
    // ลบไฟล์ทิ้ง
    await widget.storage.deleteFile();
    setState(() {
      _counter = 0;
    });
    if(mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ลบไฟล์ข้อมูลแล้ว! เริ่มนับใหม่')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('อ่าน/เขียน ไฟล์ในเครื่อง')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('ตำแหน่งไฟล์ที่บันทึก (Path):', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(_filePath, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: Colors.grey)),
            const SizedBox(height: 30),
            
            const Text('คุณกดปุ่มไปแล้ว (ครั้ง):'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            
            const SizedBox(height: 30),
            // ปุ่ม Reset (ลบไฟล์)
            OutlinedButton.icon(
              onPressed: _resetCounter,
              icon: const Icon(Icons.delete, color: Colors.red),
              label: const Text("ลบไฟล์ (Reset)", style: TextStyle(color: Colors.red)),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}