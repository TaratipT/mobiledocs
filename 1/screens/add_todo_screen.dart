// import 'package:flutter/material.dart';

// class AddTodoScreen extends StatefulWidget {
//   const AddTodoScreen({super.key});

//   @override
//   State<AddTodoScreen> createState() => _AddTodoState();
// }

// class _AddTodoState extends State<AddTodoScreen> {
//   final myController = TextEditingController();

//   @override
//   void dispose() {
//     myController.dispose();
//     super.dispose();
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     const appTitle = 'Add Todo';
//     return MaterialApp(
//       title: appTitle,
//       home: Scaffold(
//         appBar: AppBar(title: const Text(appTitle)),
//         body: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'Enter a title',
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//                 child: TextFormField(
//                   decoration: const InputDecoration(
//                     border: UnderlineInputBorder(),
//                     labelText: 'Enter your description',
//                   ),
//                 ),
//               ),
//             ],
//           )
//       )
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../models/todo.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
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
    );
  }
}