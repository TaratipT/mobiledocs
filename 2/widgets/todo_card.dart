import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../screens/todo_detail.dart';

class TodoCard extends StatelessWidget {
  final TodoList list;
  final VoidCallback onDelete;
  final VoidCallback onEdit; // 1. เพิ่มตัวรับคำสั่งแก้ไข

  const TodoCard({
    super.key,
    required this.list,
    required this.onDelete,
    required this.onEdit, // 2. บังคับให้ส่งมาด้วย
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(list.name),
            subtitle: Text(list.description),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodoDetailScreen(todo: list),
                ),
              );
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(list.status),
                const SizedBox(width: 8),
                
                // 3. ปุ่มแก้ไข (สีน้ำเงิน)
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: onEdit, // เรียกคำสั่ง onEdit
                ),
                
                // ปุ่มลบ (สีแดง)
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}