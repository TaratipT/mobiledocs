import 'package:flutter/material.dart';
import '../models/todo.dart';

class EditTodoScreen extends StatefulWidget {
  final TodoList todo; // บังคับว่าต้องส่งข้อมูลเดิมมา

  const EditTodoScreen({super.key, required this.todo});

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // ดึงค่าเดิมมาใส่ในช่องข้อความ
    nameController.text = widget.todo.name;
    descController.text = widget.todo.description;
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'), // ชื่อหัวข้อชัดเจน
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Task Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  // สร้าง object ใหม่ โดยใช้ข้อมูลใหม่ที่แก้ + สถานะเดิม
                  TodoList updatedTodo = TodoList(
                    name: nameController.text,
                    description: descController.text,
                    status: widget.todo.status, 
                  );

                  // ส่งข้อมูลที่แก้แล้วกลับไป
                  Navigator.pop(context, updatedTodo);
                }
              },
              child: const Text('Update Todo'),
            )
          ],
        ),
      ),
    );
  }
}