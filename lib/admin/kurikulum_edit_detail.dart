// kurikulum_edit_detail.dart
import 'package:flutter/material.dart';

class EditKurikulumDetailPage extends StatelessWidget {
  final String title;
  final String description;

  const EditKurikulumDetailPage(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: title);
    final descriptionController = TextEditingController(text: description);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Detail Kurikulum'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Judul Kurikulum'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}