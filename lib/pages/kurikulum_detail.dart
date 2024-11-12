import 'package:flutter/material.dart';

class KurikulumDetailPage extends StatelessWidget {
  final String kelas;
  final String description; // Menambahkan parameter description

  // Konstruktor menerima kelas dan description
  const KurikulumDetailPage({
    super.key,
    required this.kelas,
    required this.description, // Menambahkan parameter description
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Kurikulum - Kelas $kelas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Membuat halaman scrollable
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kurikulum $kelas',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                description, // Menampilkan deskripsi yang diterima
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 94, 94, 94),
                ),
              ),
              const SizedBox(height: 16),
              // Tambahkan informasi detail kurikulum sesuai kelas di sini
              // Misalnya, Anda bisa menambahkan informasi lain yang relevan
            ],
          ),
        ),
      ),
    );
  }
}
