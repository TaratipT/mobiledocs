import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/todo_screen.dart';
import 'package:flutter_application_1/screens/add_todo_screen.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoList',
      theme: ThemeData(primarySwatch: Colors.red),
      home: HomeScreen(),
    );
  }
}
