import 'package:flutter/material.dart';
import '../models/user_item.dart';
import '../widgets/user_card.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ข้อมูลจำลอง
  List<UserItem> users = [
    UserItem(name: "John Doe", email: "john@example.com"),
    UserItem(name: "Jane Smith", email: "jane@test.com"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List (Home)')),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return UserCard(
            user: users[index],
            onTap: () async {
              // 1. ส่งค่าไป Detail และรอฟังผลลัพธ์ (await)
              final updatedResult = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(user: users[index]),
                ),
              );

              // 2. เมื่อ Detail กด Back กลับมา พร้อมข้อมูลใหม่
              if (updatedResult != null && updatedResult is UserItem) {
                // "เปลี่ยนค่า ณ หน้านั้น" (อัปเดต List)
                setState(() {
                  users[index] = updatedResult;
                });
              }
            },
          );
        },
      ),
    );
  }
}