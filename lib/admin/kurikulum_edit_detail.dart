import 'package:flutter/material.dart';

class EditKurikulumDetailPage extends StatefulWidget {
  final String title;
  final String description;

  // Constructor yang menerima title dan description
  const EditKurikulumDetailPage({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  EditKurikulumDetailPageState createState() =>
      EditKurikulumDetailPageState();
}

class EditKurikulumDetailPageState extends State<EditKurikulumDetailPage> {
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    // Set initial value for description field
    _descriptionController = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${widget.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit Deskripsi ${widget.title}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Logic to update Firestore can be added here
                Navigator.pop(context, _descriptionController.text);
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
