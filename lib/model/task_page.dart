import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Tugas"),
      ),
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection('tugas').get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text("Tidak ada tugas yang tersedia."));
              }

              final tugasList = snapshot.data!.docs;

              return ListView.builder(
                itemCount: tugasList.length,
                itemBuilder: (context, index) {
                  final data = tugasList[index].data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data['title'] ?? 'Judul tidak tersedia'),
                    subtitle: Text(data['description'] ?? 'Deskripsi tidak tersedia'),
                    trailing: Text(data['time'] ?? 'Waktu tidak diketahui'),
                  );
                },
              );
            },
          ),
          Positioned(
            bottom: 70, // Jarak dari bawah
            right: 30,  // Jarak dari kanan
            child: FloatingActionButton(
              onPressed: () {
                // Aksi yang akan dijalankan ketika tombol ditekan
              },
              backgroundColor: const Color.fromARGB(255, 103, 210, 106),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.white)
            ),
          ),
        ],
      ),
    );
  }
}
