import 'package:flutter/material.dart';
import 'package:studyit/pages/news.dart';
import 'news_edit.dart';

class NewsAdmin extends StatelessWidget {
  const NewsAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const EventPage(), // Halaman konten utama
          Positioned(
            right: 20, // Jarak dari kanan
            bottom: 20, // Jarak dari bawah
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewsEdit()), // Navigate to NewsEdit page
                );
              },
              backgroundColor: const Color.fromARGB(255, 103, 210, 106), // Mengubah warna FAB di sini
              child: const Icon(Icons.edit, color: Colors.white), // Ikon pensil
            ),
          ),
        ],
      ),
    );
  }
}
