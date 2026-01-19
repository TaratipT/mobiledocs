import 'package:flutter/material.dart';
import '../models/todo.dart';
import 'edit_todo_screen.dart'; // Import หน้า Edit ใหม่

class TodoDetailScreen extends StatelessWidget {
  final TodoList todo;

  const TodoDetailScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.name),
        actions: [
          // ปุ่ม Edit
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              // ไปที่หน้า EditTodoScreen
              final updatedTodo = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTodoScreen(todo: todo),
                ),
              );

              // ถ้าแก้ไขเสร็จแล้ว
              if (updatedTodo is TodoList && context.mounted) {
                // ปิดหน้า Detail และส่งข้อมูลใหม่กลับไปให้ Home อัปเดต
                Navigator.pop(context, {'action': 'update', 'data': updatedTodo});
              }
            },
          ),
          // ปุ่ม Delete
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Navigator.pop(context, {'action': 'delete'});
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Description:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(todo.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 30),
            const Text("Status:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: todo.status == 'Done' ? Colors.green[100] : Colors.amber[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(todo.status, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}