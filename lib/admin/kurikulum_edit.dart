import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studyit/admin/kurikulum_edit_detail.dart';

class KurikulumEditPage extends StatelessWidget {
  const KurikulumEditPage({super.key});

  Future<void> _addInitialData() async {
    try {
      // Menambahkan dokumen baru dengan field deskripsi untuk kelas 7, 8, dan 9
      await FirebaseFirestore.instance.collection('kurikulum').doc('kelas_deskripsi').set({
        'kelas_7': 'Deskripsi untuk Kelas 7',
        'kelas_8': 'Deskripsi untuk Kelas 8',
        'kelas_9': 'Deskripsi untuk Kelas 9',
      });
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Edit Kurikulum',
          style: TextStyle(
            fontFamily: "poppins",
            color: Color.fromARGB(255, 93, 174, 96),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.2,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(
            color: const Color.fromARGB(40, 0, 0, 0),
            height: 0.7,
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('kurikulum').doc('kelas_deskripsi').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Terjadi kesalahan'));
          }

          if (!snapshot.hasData || snapshot.data == null || !snapshot.data!.exists) {
            // Jika data tidak ditemukan, tambahkan data default
            _addInitialData();
            return const Center(child: Text('Data sedang ditambahkan...'));
          }

          var data = snapshot.data!;
          String kelas7Description = data['kelas_7'] ?? 'Deskripsi untuk Kelas 7';
          String kelas8Description = data['kelas_8'] ?? 'Deskripsi untuk Kelas 8';
          String kelas9Description = data['kelas_9'] ?? 'Deskripsi untuk Kelas 9';

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildKurikulumTile(context, 'Kelas 7', kelas7Description),
              _buildKurikulumTile(context, 'Kelas 8', kelas8Description),
              _buildKurikulumTile(context, 'Kelas 9', kelas9Description),
            ],
          );
        },
      ),
    );
  }

  Widget _buildKurikulumTile(
      BuildContext context, String title, String description) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SizedBox(
        height: 100,
        child: Center(
          child: ListTile(
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 97, 97, 97),
              ),
            ),
            subtitle: Text(description),
            trailing: IconButton(
              icon: const Icon(Icons.edit,
                  color: Color.fromARGB(255, 96, 183, 99)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditKurikulumDetailPage(
                        title: title, description: description),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
