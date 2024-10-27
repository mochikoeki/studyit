import 'package:flutter/material.dart';

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
            letterSpacing: -0.2, // Mengatur jarak antar huruf
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
          // Tambahkan lebih banyak kurikulum sesuai kebutuhan
        ],
      ),
    );
  }

  Widget _buildKurikulumTile(
      BuildContext context, String title, String description) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white, // Set warna latar belakang menjadi putih
        borderRadius:
            BorderRadius.circular(10.0), // Radius untuk sudut yang halus
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Warna shadow
            spreadRadius: 2, // Jarak penyebaran shadow
            blurRadius: 6, // Radius blur shadow
            offset: const Offset(0, 4), // Posisi shadow
          ),
        ],
      ),
      child: SizedBox(
        height: 100, // Menentukan tinggi box
        child: Center(
          // Memastikan item di dalam box rata tengah secara vertikal
          child: ListTile(
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 97, 97, 97), // Menebalkan judul
              ),
            ),
            subtitle: Text(description),
            trailing: IconButton(
              icon: const Icon(Icons.edit,
                  color: Color.fromARGB(255, 96, 183, 99)),
              onPressed: () {
                // Arahkan ke halaman detail edit kurikulum
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

class EditKurikulumDetailPage extends StatelessWidget {
  final String title;
  final String description;

  const EditKurikulumDetailPage(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: title);
    final descriptionController = TextEditingController(text: description);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Detail Kurikulum'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Judul Kurikulum'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}
