import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart'; // อย่าลืม import
import 'package:path/path.dart';      // อย่าลืม import
import '../models/todo.dart';
import '../widgets/todo_card.dart';
import 'add_todo_screen.dart';
import 'todo_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // สร้างตัวแปรเก็บ Database
  Database? db;
  
  // ตัวแปรเก็บรายการเดิมของคุณ
  List<TodoList> lists = [];

  @override
  void initState() {
    super.initState();
    // เปิดแอปปุ๊บ ให้เชื่อมต่อ Database ทันที
    initDatabase();
  }

  // ฟังก์ชันเปิด/สร้าง Database (ลอกมาจาก tutorial แล้วปรับนิดหน่อย)
  void initDatabase() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        // สร้างตารางเมื่อรันครั้งแรก
        return db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY, name TEXT, description TEXT, status TEXT)',
        );
      },
      version: 1,
    );

    // พอเชื่อมเสร็จ ให้โหลดข้อมูลมาโชว์
    loadData();
  }

  // ฟังก์ชันดึงข้อมูลจาก DB มาใส่ใน List
  void loadData() async {
    if (db == null) return;
    
    // ดึงข้อมูลทั้งหมด
    final List<Map<String, dynamic>> maps = await db!.query('todos');

    // แปลงข้อมูลจาก DB กลับมาเป็น List<TodoList> ของเรา
    setState(() {
      lists = List.generate(maps.length, (i) {
        return TodoList(
          id: maps[i]['id'],
          name: maps[i]['name'],
          description: maps[i]['description'],
          status: maps[i]['status'],
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Todolist (SQL)')),
      body: ListView.builder(
        itemCount: lists.length,
        itemBuilder: (context, index) {
          return TodoCard(
            list: lists[index],
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodoDetailScreen(todo: lists[index]),
                ),
              );

              // *** ส่วนการ ลบ และ แก้ไข ***
              if (result != null && result is Map) {
                if (result['action'] == 'delete') {
                  // สั่งลบจาก DB โดยใช้ id
                  await db!.delete(
                    'todos',
                    where: 'id = ?',
                    whereArgs: [lists[index].id],
                  );
                } else if (result['action'] == 'update') {
                  // สั่งอัปเดตลง DB
                  TodoList updatedItem = result['data'];
                  await db!.update(
                    'todos',
                    updatedItem.toMap(),
                    where: 'id = ?',
                    whereArgs: [updatedItem.id], // ใช้ id เดิมในการอ้างอิง
                  );
                }
                // โหลดข้อมูลใหม่ทั้งหมดเพื่อแสดงผล
                loadData();
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final newTodo = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTodoScreen()),
          );

          if (newTodo is TodoList) {
            // *** ส่วนการเพิ่มลง DB ***
            await db!.insert(
              'todos',
              newTodo.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
            
            // โหลดข้อมูลใหม่มาแสดง
            loadData();
          }
        },
      ),
    );
  }
}