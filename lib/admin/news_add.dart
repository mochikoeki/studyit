import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  String? _selectedCategory = 'event'; // Kategori berita

  // Fungsi untuk memilih gambar
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Mengatur gambar yang dipilih
      });
    }
  }

  // Fungsi untuk meng-upload gambar ke Firebase Storage
  Future<String> _uploadImage(File imageFile) async {
    try {
      // Menyimpan gambar ke Firebase Storage
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('articles/${DateTime.now().millisecondsSinceEpoch}.jpg');
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  // Fungsi untuk menyimpan artikel ke Firestore
  Future<void> _saveArticle() async {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _image != null &&
        _selectedCategory != null) {
      try {
        // Upload gambar ke Firebase Storage dan dapatkan URL-nya
        String imageUrl = await _uploadImage(_image!);

        // Menyimpan artikel ke Firestore dengan URL gambar
        await FirebaseFirestore.instance.collection('articles').add({
          'title': _titleController.text,
          'description': _descriptionController.text,
          'category': _selectedCategory,
          'image': imageUrl, // Menyimpan URL gambar
          'timestamp': FieldValue.serverTimestamp(), // Waktu artikel dibuat
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Berita Berhasil Disimpan!')),
          );
        }

        // Kembali ke halaman sebelumnya setelah berhasil menyimpan
        if (mounted) {
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error saving article: $e')),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Silakan lengkapi semua field!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Tambah Berita',
          style: TextStyle(
            fontFamily: "poppins",
            color: Color.fromARGB(255, 93, 174, 96),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.2,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.save,
              color: Colors.green,
            ),
            onPressed: _saveArticle, // Simpan artikel saat ikon disimpan ditekan
          ),
        ],
      ),
      body: SingleChildScrollView(
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
            const SizedBox(height: 16.0),
            InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Kategori Berita',
                border: OutlineInputBorder(),
              ),
              child: DropdownButton<String>(
                value: _selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                items: <String>['event', 'artikel']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
