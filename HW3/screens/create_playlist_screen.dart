// File: lib/screens/create_playlist_screen.dart
import 'package:flutter/material.dart';
import 'playlist_view_screen.dart'; 

class CreatePlaylistScreen extends StatefulWidget {
  const CreatePlaylistScreen({super.key});

  @override
  State<CreatePlaylistScreen> createState() => _CreatePlaylistScreenState();
}

class _CreatePlaylistScreenState extends State<CreatePlaylistScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  
  String _privacy = 'สาธารณะ'; 

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newPlaylist = PlaylistData(
        title: _titleController.text,
        description: _descController.text,
        privacy: _privacy,
      );
      Navigator.pop(context, newPlaylist);
    }
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1F1F),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "เพลย์ลิสต์ใหม่",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),

                // 1. ช่องกรอกชื่อ (แก้ไข Validator ตรงนี้)
                _buildTextField(
                  controller: _titleController,
                  label: "ชื่อ",
                  autoFocus: true,
                  // [แก้จุดที่ 1] ใส่ข้อความเตือนเมื่อค่าว่าง
                  validator: (value) => value == null || value.isEmpty ? 'โปรดกรอกชื่อ' : null,
                ),
                
                const SizedBox(height: 20),

                // 2. ช่องกรอกคำอธิบาย
                _buildTextField(
                  controller: _descController,
                  label: "คำอธิบาย",
                ),

                const SizedBox(height: 30),

                // 3. Dropdown
                DropdownButtonFormField<String>(
                  value: _privacy,
                  dropdownColor: const Color(0xFF2C2C2C),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: "ความเป็นส่วนตัว",
                    labelStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                  items: [
                    _buildDropdownItem("สาธารณะ", Icons.public),
                    _buildDropdownItem("ไม่เป็นสาธารณะ", Icons.link),
                    _buildDropdownItem("ส่วนตัว", Icons.lock_outline),
                  ],
                  onChanged: (value) => setState(() => _privacy = value!),
                ),
                
                const SizedBox(height: 60),

                // 4. ปุ่ม Action
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _cancel,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("ยกเลิก", style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.15),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      ),
                      child: const Text("สร้าง", style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool autoFocus = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      autofocus: autoFocus,
      style: const TextStyle(color: Colors.white, fontSize: 18),
      cursorColor: Colors.white,
      validator: validator,
      // [แก้จุดที่ 2] ปรับแต่ง InputDecoration ให้รองรับ Error State สวยๆ
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[400]),
        
        // เส้นปกติ (สีเทา)
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        // เส้นตอนพิมพ์ (สีขาว)
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        
        // เส้นตอน Error (สีแดง)
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        // เส้นตอนพิมพ์และ Error (สีแดงหนา)
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        
        // สีตัวหนังสือ Error (ปกติเป็นแดงอยู่แล้ว แต่กำหนดให้ชัวร์)
        errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
      ),
    );
  }

  DropdownMenuItem<String> _buildDropdownItem(String value, IconData icon) {
    return DropdownMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[400], size: 20),
          const SizedBox(width: 12),
          Text(value),
        ],
      ),
    );
  }
}