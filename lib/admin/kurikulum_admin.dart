import 'package:flutter/material.dart';
import 'package:studyit/admin/kurikulum_edit.dart';
import 'package:studyit/pages/kurikulum.dart';


class KurikulumAdmin extends StatelessWidget {
  const KurikulumAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const KurikulumPage(), // Menggunakan widget KurikulumPage dari kurikulum.dart
          Positioned(
            right: 20, // Jarak dari kanan
            bottom: 20, // Jarak dari bawah
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          KurikulumEditPage()), // Ganti dengan halaman edit
                );
              },
              backgroundColor: const Color.fromARGB(
                  255, 103, 210, 106), // Mengubah warna FAB di sini
              child: const Icon(Icons.edit, color: Colors.white), // Ikon pensil
            ),
          ),
        ],
      ),
    );
  }
}
