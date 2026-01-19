import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RegisterScreen(),
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>(); // Key สำคัญสำหรับ Form

  // ต้องใช้ Controller เพื่อดึงค่า Password ไปเทียบกับ Confirm Password
  final passCtrl = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inline Validation')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              // ---------------------------------------------
              // 1. ชื่อ (ห้ามว่าง + ขั้นต่ำ 3 ตัว)
              // ---------------------------------------------
              const Text("Full Name"),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Enter your name'),
                validator: (value) {
                  // เช็คว่าว่างไหม
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name'; 
                  }
                  // เช็คความยาว
                  if (value.length < 3) {
                    return 'Name must be at least 3 characters';
                  }
                  return null; // ผ่าน
                },
              ),
              const SizedBox(height: 20),

              // ---------------------------------------------
              // 2. อีเมล (เช็ค Regex)
              // ---------------------------------------------
              const Text("Email"),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Enter email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter email';
                  }
                  // Logic เช็คอีเมลด้วย Regex
                  bool emailValid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                  if (!emailValid) {
                    return 'Invalid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // ---------------------------------------------
              // 3. อายุ (เช็คเป็นตัวเลข + ช่วง 18-99)
              // ---------------------------------------------
              const Text("Age"),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(hintText: '18-99'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter age';
                  }
                  // แปลงเป็นตัวเลข
                  final n = int.tryParse(value);
                  if (n == null) {
                    return 'Must be a number';
                  }
                  // เช็คช่วง
                  if (n < 18 || n > 99) {
                    return 'Age must be between 18 and 99';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // ---------------------------------------------
              // 4. รหัสผ่าน (ขั้นต่ำ 8 ตัว + ต้องมีตัวใหญ่ + ต้องมีตัวเลข)
              // ---------------------------------------------
              const Text("Password"),
              const SizedBox(height: 8),
              TextFormField(
                controller: passCtrl, // ผูก Controller
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Min 8 chars, 1 Upper, 1 Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter password';
                  
                  if (value.length < 8) return 'Min 8 characters';
                  if (!value.contains(RegExp(r'[A-Z]'))) return 'Need uppercase (A-Z)';
                  if (!value.contains(RegExp(r'[0-9]'))) return 'Need number (0-9)';
                  
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // ---------------------------------------------
              // 5. ยืนยันรหัสผ่าน (ต้องตรงกับช่องบน)
              // ---------------------------------------------
              const Text("Confirm Password"),
              const SizedBox(height: 8),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Re-enter password'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please confirm password';
                  
                  // ดึงค่าจาก Controller ตัวบนมาเทียบ
                  if (value != passCtrl.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),

              // ---------------------------------------------
              // ปุ่ม Submit
              // ---------------------------------------------
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                  onPressed: () {
                    // สั่ง Validate ทั้งหมดตรงนี้
                    if (_formKey.currentState!.validate()) {
                      
                      // ถ้าผ่าน
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Success!'), backgroundColor: Colors.green),
                      );
                      
                    } else {
                      
                      // ถ้าไม่ผ่าน
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fix errors'), backgroundColor: Colors.red),
                      );
                      
                    }
                  },
                  child: const Text("REGISTER"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}