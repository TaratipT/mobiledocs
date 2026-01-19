import 'package:flutter/material.dart';
import '../models/todo.dart';

class EditTodoScreen extends StatefulWidget {
  final TodoList todo;

  const EditTodoScreen({super.key, required this.todo});

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final _formKey = GlobalKey<FormState>(); // Key สำหรับ Form
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
        title: const Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Task Name'),
                // Validate: ห้ามว่าง (ตัดช่องว่างหน้าหลังออกก่อนเช็ค)
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter task name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Description'),
                // Validate: ห้ามว่าง (ลบเงื่อนไข 4 ตัวอักษรออกแล้วตามที่ขอ)
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    
                    TodoList updatedTodo = TodoList(
                      // *** จุดสำคัญที่แก้: ต้องส่ง ID เดิมกลับไปด้วย ***
                      id: widget.todo.id, 
                      
                      name: nameController.text,
                      description: descController.text,
                      status: widget.todo.status,
                    );

                    Navigator.pop(context, updatedTodo);
                  }
                },
                child: const Text('Update Todo'),
              )
            ],
          ),
        ),
      ),
    );
  }
}