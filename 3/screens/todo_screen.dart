import 'package:flutter/material.dart';
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
  List<TodoList> lists = [
    TodoList(name: 'Sleep', description: 'SleepNow', status: 'Done'),
    TodoList(name: 'Maibok', description: 'Euei', status: 'Not Done')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Todolist')),
      body: ListView.builder(
        itemCount: lists.length,
        itemBuilder: (context, index) {
          // ส่ง onTap เข้าไปใน Card
          return TodoCard(
            list: lists[index],
            onTap: () async {
              // 1. เปิดหน้า Detail และรอผลลัพธ์ (await)
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodoDetailScreen(todo: lists[index]),
                ),
              );

              // 2. ตรวจสอบผลลัพธ์ที่ส่งกลับมา
              if (result != null && result is Map) {
                if (result['action'] == 'delete') {
                  // ถ้าสั่งลบ
                  setState(() {
                    lists.removeAt(index);
                  });
                } else if (result['action'] == 'update') {
                  // ถ้าสั่งแก้ไข (อัปเดตข้อมูลในตำแหน่งเดิม)
                  setState(() {
                    lists[index] = result['data'];
                  });
                }
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
            setState(() {
              lists.add(newTodo);
            });
          }
        },
      ),
    );
  }
}