import 'package:flutter/material.dart';

class KurikulumDetailPage extends StatelessWidget {
  final String kelas;

  const KurikulumDetailPage({super.key, required this.kelas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Kurikulum $kelas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              'Detail lengkap untuk Kurikulum $kelas.',
              style: const TextStyle(fontSize: 16),
            ),
            // Tambahkan informasi detail kurikulum sesuai kelas di sini
          ],
        ),
      ),
    );
  }
}
