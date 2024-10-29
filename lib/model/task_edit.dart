import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskEditPage extends StatefulWidget {
  const TaskEditPage({super.key});

  @override
  TaskEditPageState createState() => TaskEditPageState();
}

class TaskEditPageState extends State<TaskEditPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _teacherController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _urlController = TextEditingController(); // Tambahkan controller untuk URL

  Future<void> _addTask() async {
    String title = _titleController.text;
    String teacher = _teacherController.text;
    String description = _descriptionController.text;
    String url = _urlController.text;
    String time = DateTime.now().toString(); // Waktu otomatis saat tugas ditambahkan

    if (title.isNotEmpty && teacher.isNotEmpty && description.isNotEmpty && url.isNotEmpty) {
      await FirebaseFirestore.instance.collection('tugas').add({
        'title': title,
        'teacher': teacher,
        'description': description,
        'url': url, // Tambahkan URL ke Firestore
        'time': time,
      });

      // ignore: use_build_context_synchronously
      Navigator.pop(context); // Kembali ke halaman sebelumnya setelah menambah tugas
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Tugas Baru"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Judul Task",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _teacherController,
              decoration: const InputDecoration(
                labelText: "Nama Guru",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Deskripsi",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: "URL",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _addTask,
              child: const Text("Tambah Tugas"),
            ),
          ],
        ),
      ),
    );
  }
}
