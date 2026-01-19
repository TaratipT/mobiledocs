import 'dart:async';
import 'package:flutter/material.dart';
// 1. เปลี่ยนวิธี import เป็นการตั้งชื่อเล่นว่า "p"
import 'package:path/path.dart' as p; 
import 'package:sqflite/sqflite.dart';

// --- 1. Data Model ---
class Dog {
  final int id;
  final String name;
  final int age;

  const Dog({required this.id, required this.name, required this.age});

  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'age': age};
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}

// --- 2. Main Entry Point ---
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const DogHomePage(),
    );
  }
}

// --- 3. UI & Logic Screen ---
class DogHomePage extends StatefulWidget {
  const DogHomePage({super.key});

  @override
  State<DogHomePage> createState() => _DogHomePageState();
}

class _DogHomePageState extends State<DogHomePage> {
  Database? _database;
  List<Dog> _dogs = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      // 2. เรียกใช้ join ผ่าน p.join (แก้ตรงนี้)
      p.join(await getDatabasesPath(), 'doggie_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      version: 1,
    );
    _refreshDogList();
  }

  Future<void> _refreshDogList() async {
    if (_database == null) return;
    final List<Map<String, Object?>> dogMaps = await _database!.query('dogs');
    setState(() {
      _dogs = [
        for (final {'id': id as int, 'name': name as String, 'age': age as int} in dogMaps)
          Dog(id: id, name: name, age: age),
      ];
    });
  }

  Future<void> _addDog(String name, int age) async {
    if (_database == null) return;
    final newDog = Dog(
      id: DateTime.now().millisecondsSinceEpoch, 
      name: name, 
      age: age
    );
    await _database!.insert(
      'dogs',
      newDog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _refreshDogList();
  }

  Future<void> _updateDog(int id, String name, int age) async {
    if (_database == null) return;
    final updatedDog = Dog(id: id, name: name, age: age);
    await _database!.update(
      'dogs',
      updatedDog.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
    _refreshDogList();
  }

  Future<void> _deleteDog(int id) async {
    if (_database == null) return;
    await _database!.delete(
      'dogs',
      where: 'id = ?',
      whereArgs: [id],
    );
    _refreshDogList();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ลบข้อมูลเรียบร้อย')));
    }
  }

  void _showForm(int? id) {
    if (id != null) {
      final existingDog = _dogs.firstWhere((element) => element.id == id);
      _nameController.text = existingDog.name;
      _ageController.text = existingDog.age.toString();
    } else {
      _nameController.clear();
      _ageController.clear();
    }

    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 120,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'ชื่อสุนัข (Name)'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'อายุ (Age)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_nameController.text.isNotEmpty && _ageController.text.isNotEmpty) {
                  final name = _nameController.text;
                  final age = int.parse(_ageController.text);

                  if (id == null) {
                    await _addDog(name, age);
                  } else {
                    await _updateDog(id, name, age);
                  }

                  if (mounted) {
                    Navigator.of(context).pop();
                    _nameController.clear();
                    _ageController.clear();
                  }
                }
              },
              child: Text(id == null ? 'เพิ่มข้อมูลใหม่' : 'บันทึกแก้ไข'),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite Dog Manager'),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        foregroundColor: Colors.white,
      ),
      body: _dogs.isEmpty
          ? const Center(child: Text('ยังไม่มีข้อมูลสุนัข กดปุ่ม + เพื่อเพิ่ม'))
          : ListView.builder(
              itemCount: _dogs.length,
              itemBuilder: (context, index) {
                final dog = _dogs[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      child: Text(dog.age.toString(), style: const TextStyle(color: Colors.white)),
                    ),
                    title: Text(dog.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('ID: ${dog.id}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () => _showForm(dog.id),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteDog(dog.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(null),
        child: const Icon(Icons.add),
      ),
    );
  }
}