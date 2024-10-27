import 'package:flutter/material.dart';
import 'package:studyit/model/task_page.dart';
import 'package:studyit/pages/beranda.dart';

class BerandaAdmin extends StatelessWidget {
  const BerandaAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(child: HomeContent()), // Menggunakan HomeContent dari beranda.dart
          _buildAddQuestionBox(context), // Kirim context ke _buildAddQuestionBox
        ],
      ),
    );
  }

  // Pastikan context diterima sebagai parameter
  Widget _buildAddQuestionBox(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TaskListPage()),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.white),
            SizedBox(width: 8.0),
            Text(
              'Tambahkan Soal',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
