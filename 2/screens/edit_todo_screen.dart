import 'package:flutter/material.dart';
import '../models/todo.dart';

class EditTodoScreen extends StatefulWidget {
  final TodoList todo; // 1. รับข้อมูลเก่าเข้ามา

  const EditTodoScreen({super.key, required this.todo});

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  late TextEditingController nameController;
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();
    // 2. กำหนดค่าเริ่มต้นให้ช่องกรอก โดยดึงจากข้อมูลเก่าที่ส่งมา
    nameController = TextEditingController(text: widget.todo.name);
    descController = TextEditingController(text: widget.todo.description);
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
        title: const Text('Edit Task'), // เปลี่ยนหัวข้อเป็น Edit
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
                  // 3. สร้างข้อมูลก้อนใหม่
                  TodoList updatedTodo = TodoList(
                    name: nameController.text,
                    description: descController.text,
                    status: widget.todo.status, // สถานะใช้ของเดิม
                  );

                  // 4. ส่งข้อมูลใหม่กลับไปหน้าหลัก
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