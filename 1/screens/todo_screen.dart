// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/screens/add_todo_screen.dart';
// import '../models/todo.dart';
// import '../widgets/todo_card.dart';

// class HomeScreen extends StatelessWidget {
//   final List<TodoList> lists = [
//     TodoList(name: 'Sleep', description: 'SleepNow', status: 'Done'),
//     TodoList(name: 'Eat', description: 'EatNow', status: 'Done')
//   ];

//   HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('My Todolist')),
//       body: ListView.builder(
//         itemCount: lists.length,
//         itemBuilder: (context, index) {
//           return TodoCard(list: lists[index]);
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute<void>(
//               builder: (context) => const AddTodoScreen(),
//             ));
//         }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../widgets/todo_card.dart';
import 'add_todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TodoList> lists = [
    TodoList(name: 'Sleep', description: 'SleepNow', status: 'Done'),
    TodoList(name: 'Sleepz', description: 'SleepNows', status: 'Donez'),
    TodoList(name: 'Maibok', description: 'Euei', status: 'Not Done')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Todolist')),
      body: ListView.builder(
        itemCount: lists.length,
        itemBuilder: (context, index) {
          return TodoCard(list: lists[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final newTodo = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTodoScreen()),
          );

          // 2. ถ้ามีค่าส่งกลับมา (ไม่เป็น null) ให้เพิ่มลง List
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