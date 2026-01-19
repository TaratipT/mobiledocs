import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoCard extends StatelessWidget {
  final TodoList list;
  final VoidCallback onTap; // เพิ่มตัวแปรรับฟังก์ชันเมื่อถูกกด

  // แก้ไข Constructor ให้รับ onTap
  const TodoCard({super.key, required this.list, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(list.name),
            subtitle: Text(list.description),
            trailing: Text(list.status),
            onTap: onTap, // เรียกใช้ฟังก์ชันที่ส่งเข้ามา
          )
        ],
      ),
    );
  }
}