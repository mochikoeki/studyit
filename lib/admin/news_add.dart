import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NewsAdd extends StatefulWidget {
  const NewsAdd({super.key});

  @override
  NewsAddState createState() => NewsAddState();
}

class NewsAddState extends State<NewsAdd> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image; // Variabel untuk menyimpan file gambar

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Mengatur gambar yang dipilih
      });
    }
  }

  void _saveArticle() {
    // Logika untuk menyimpan artikel baru, misalnya menambah ke daftar artikel
    if (_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty && _image != null) {
      // Anda bisa menambahkan logika untuk menyimpan artikel di sini
      Navigator.pop(context); // Kembali ke halaman sebelumnya
    } else {
      // Tampilkan pesan kesalahan jika input tidak lengkap
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan lengkapi semua field!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Berita'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveArticle, // Simpan artikel saat ikon disimpan ditekan
          ),
        ],
      ),
      body: SingleChildScrollView( // Membungkus dengan SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: _image == null
                    ? const Center(child: Text('Tap to add image'))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Judul Berita',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Isi Berita',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
