import 'package:flutter/material.dart';

import 'beranda.dart';

class TugasPage extends StatelessWidget {
  final Task task; // Objek Task yang akan diterima

  const TugasPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title), // Judul sesuai tugas
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' ${task.teacher}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              task.description,
              style: const TextStyle(fontSize: 16),
            ),
            // Tambahkan komponen lainnya sesuai kebutuhan tugas
          ],
        ),
      ),
    );
  }
}
