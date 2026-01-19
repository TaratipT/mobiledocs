import 'package:flutter/material.dart';
import '../models/user_item.dart';

class UserCard extends StatelessWidget {
  final UserItem user;
  final VoidCallback onTap; // รับฟังก์ชันกดจากภายนอก

  const UserCard({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(child: Text(user.name[0])),
        title: Text(user.name),
        subtitle: Text(user.email),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}