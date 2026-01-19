import 'package:flutter/material.dart';
import '../models/user_item.dart';

class EditScreen extends StatefulWidget {
  final UserItem user; // 1. รับค่า "ส่งไป" (Forward)

  const EditScreen({super.key, required this.user});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController nameCtrl;
  late TextEditingController emailCtrl;

  @override
  void initState() {
    super.initState();
    // เอาค่าเดิมมาใส่ใน Controller
    nameCtrl = TextEditingController(text: widget.user.name);
    emailCtrl = TextEditingController(text: widget.user.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit User')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // สร้าง Object ใหม่
                UserItem updatedUser = UserItem(
                  name: nameCtrl.text,
                  email: emailCtrl.text,
                );

                // 2. ส่งค่า "ส่งคืน" (Backward) กลับไปหน้าก่อนหน้า
                Navigator.pop(context, updatedUser);
              },
              child: const Text('Save & Return'),
            )
          ],
        ),
      ),
    );
  }
}