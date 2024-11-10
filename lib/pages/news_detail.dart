import 'package:flutter/material.dart';

class DetailNewsPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const DetailNewsPage({
    required this.imagePath,
    required this.title,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Mengubah ikon back button
        leading: IconButton(
          iconSize: 16,
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color.fromARGB(255, 106, 195, 109)), // Ganti ikon dan warna di sini
          onPressed: () {
            Navigator.pop(context); // Aksi untuk kembali ke halaman sebelumnya
          },
        ),
        title: const Text('News'),
        centerTitle: false, // Agar judul tidak di tengah
        actions: const [
          Spacer(), // Menambahkan spacer untuk meratakan teks ke kanan
          Padding(
            padding: EdgeInsets.only(
                right: 20.0), // Menambahkan padding di sebelah kanan
            child: Row(
              children: [
                Text(
                  'News',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 80, 146, 83), // Warna teks
                  ),
                ),
                SizedBox(width: 8), // Jarak antara teks dan ikon
                Icon(
                  size: 18,
                  Icons.article_rounded, // Ikon yang ingin ditampilkan
                  color: Color.fromARGB(255, 80, 146, 83), // Warna ikon
                ),
              ],
            ),
          ),
        ],
        backgroundColor: Colors.white, // Ganti warna AppBar
        elevation: 0, // Menghapus shadow bawaan AppBar
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(1.0), // Ukuran height dari border
          child: Container(
            color: const Color.fromARGB(39, 0, 0, 0), // Warna border hitam
            height: 1.0, // Ketebalan border
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menampilkan gambar menggunakan Image.network
            Image.network(imagePath, fit: BoxFit.cover),
            const SizedBox(height: 16.0),
            // Menampilkan judul artikel
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            // Menampilkan deskripsi artikel
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
