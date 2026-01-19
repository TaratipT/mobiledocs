import 'package:flutter/material.dart';
import '../models/todo.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  // 1. สร้าง Key สำหรับ Form
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

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
        title: const Text('Add New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // 2. ห่อ Column ด้วย Form และใส่ key
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 3. เปลี่ยนเป็น TextFormField
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Task Name'),
                // Validation สำหรับชื่อ (ห้ามว่าง)
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter task name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Description'),
                // 4. Validation สำหรับ Description (ต้องยาวกว่า 4 ตัว)
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  if (value.length <= 4) {
                    return 'Description must be longer than 4 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // 5. ตรวจสอบความถูกต้องก่อนบันทึก
                  if (_formKey.currentState!.validate()) {
                    
                    TodoList newTodo = TodoList(
                      name: nameController.text,
                      description: descController.text,
                      status: 'Not Done',
                    );
                    Navigator.pop(context, newTodo);
                  }
                },
                child: const Text('Save Todo'),
              )
            ],
          ),
        ),
      ),
    );
  }
}