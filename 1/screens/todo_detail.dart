import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoDetailScreen extends StatelessWidget {
  final TodoList todo;

  // รับค่า todo เข้ามาผ่าน Constructor
  const TodoDetailScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.name), // เอาชื่อ Task มาเป็นหัวข้อ
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Description:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              todo.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            const Text(
              "Status:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: todo.status == 'Done' ? Colors.green[100] : Colors.amber[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                todo.status,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}