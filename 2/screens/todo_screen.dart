import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../widgets/todo_card.dart';
import 'add_todo_screen.dart';
import 'edit_todo_screen.dart'; // อย่าลืม import ไฟล์หน้านี้

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TodoList> lists = [
    TodoList(name: 'Sleep', description: 'SleepNow', status: 'Done'),
    TodoList(name: 'Eat', description: 'EatNow', status: 'Done')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Todolist')),
      body: ListView.builder(
        itemCount: lists.length,
        itemBuilder: (context, index) {
          return TodoCard(
            list: lists[index],
            
            // ส่งคำสั่งลบ (เหมือนเดิม)
            onDelete: () {
              setState(() {
                lists.removeAt(index);
              });
            },
            
            // --- แก้ไขตรงนี้ครับ ---
            onEdit: () async {
              // 1. กระโดดไปหน้า Edit พร้อมส่งข้อมูลตัวปัจจุบัน (lists[index]) ไปด้วย
              final updatedTodo = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTodoScreen(todo: lists[index]),
                ),
              );

              // 2. ถ้ารับข้อมูลกลับมาแล้ว ให้เอาไปทับที่เดิม
              if (updatedTodo is TodoList) {
                setState(() {
                  lists[index] = updatedTodo;
                });
              }
            },
            // ---------------------
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
            setState(() {
              lists.add(newTodo);
            });
          }
        },
      ),
    );
  }
}