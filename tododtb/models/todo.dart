class TodoList {
  final int? id; // 1. เพิ่ม id (ใส่ ? เพราะตอนสร้างใหม่ยังไม่มี id)
  final String name;
  final String description;
  final String status;

  TodoList({
    this.id, // เพิ่มตรงนี้
    required this.name,
    required this.description,
    required this.status
  });

  // 2. เพิ่มฟังก์ชันแปลงเป็น Map (เหมือนในตัวอย่าง tutorial)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'status': status,
    };
  }
}