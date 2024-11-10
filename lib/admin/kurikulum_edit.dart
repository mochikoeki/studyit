import 'package:flutter/material.dart';
import 'package:studyit/admin/kurikulum_edit_detail.dart';

class KurikulumEditPage extends StatelessWidget {
  const KurikulumEditPage({super.key});

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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildKurikulumTile(context, 'Kelas 7', 'Deskripsi untuk Kelas 7'),
          _buildKurikulumTile(context, 'Kelas 8', 'Deskripsi untuk Kelas 8'),
          _buildKurikulumTile(context, 'Kelas 9', 'Deskripsi untuk Kelas 9'),
        ],
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