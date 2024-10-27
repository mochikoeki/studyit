import 'package:flutter/material.dart';
import 'package:studyit/model/tugas_model.dart'; // Pastikan model Tugas diimpor
import 'package:studyit/pages/beranda.dart';
import 'package:studyit/service/firebase_service.dart';

class BerandaAdmin extends StatelessWidget {
  const BerandaAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(child: HomeContent()), // Menggunakan HomeContent dari beranda.dart
          _buildAddQuestionBox(), // Tambahkan box di bawah HomeContent
        ],
      ),
    );
  }

  Widget _buildAddQuestionBox() {
    return GestureDetector(
      onTap: () {
        FirestoreService().tambah(
          collectionPath: 'tugas', // Pastikan untuk menyertakan path koleksi
          item: Tugas(
            time: '20 m ago',
            teacher: 'Teacher E',
            title: 'TASK 4: Title task',
            description: 'Lorem ipsum dolor sit...',
      
          ).toMap(), // Konversi Tugas ke Map
        );
      },
      child: Container(
        margin: const EdgeInsets.all(16.0), // Margin di sekitar box
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0), // Padding di dalam box
        decoration: BoxDecoration(
          color: Colors.blueAccent, // Ganti warna sesuai keinginan
          borderRadius: BorderRadius.circular(8.0), // Sudut membulat
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center, // Mengatur posisi konten di dalam row
          children: [
            Icon(Icons.add, color: Colors.white), // Ikon "+"
            SizedBox(width: 8.0), // Jarak antara ikon dan teks
            Text(
              'Tambahkan Soal',
              style: TextStyle(color: Colors.white, fontSize: 16.0), // Gaya teks
            ),
          ],
        ),
      ),
    );
  }
}
