import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../screens/todo_detail.dart';

class TodoCard extends StatelessWidget {
  final TodoList list;

const TodoCard({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(list.name),
            subtitle: Text(list.description),
            trailing: Text(list.status),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  // ส่งข้อมูล todo ตัวปัจจุบัน (list) ไปให้หน้า Detail
                  builder: (context) => TodoDetailScreen(todo: list),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
