import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'task_edit.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  // Fungsi untuk menghapus tugas
  Future<void> _deleteTask(BuildContext context, String taskId) async {
    await FirebaseFirestore.instance.collection('tugas').doc(taskId).delete();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tugas berhasil dihapus")),
      );
    }
  }

  // Memformat waktu
  String _formatTime(String? time) {
    if (time == null || time.isEmpty) {
      return 'Waktu tidak tersedia'; // Atau format default lainnya
    }
    final dateTime = DateTime.parse(time);
    return timeago.format(dateTime, locale: 'en'); // Menggunakan bahasa Inggris
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          iconSize: 16,
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color.fromARGB(255, 106, 195, 109)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        actions: const [
          Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                Text(
                  'Daftar Tugas',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 80, 146, 83),
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.task,
                  size: 18,
                  color: Color.fromARGB(255, 80, 146, 83),
                ),
              ],
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color.fromARGB(39, 0, 0, 0),
            height: 1.0,
          ),
        ),
      ),
      body: Stack(
        
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('tugas')
                .orderBy('time', descending: true) // Mengurutkan dari waktu terbaru
                .snapshots(),
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
                  final taskId = tugasList[index].id;

                  return Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 20, right: 0, left: 12),
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(208, 205, 204, 204).withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(data['title'] ?? 'Judul tidak tersedia', style: const TextStyle(
                        fontFamily: "poppins",
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 114, 114, 114)
                      ),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Guru: ${data['teacher'] ?? 'Nama guru tidak tersedia'}'),
                          Text(data['description'] ?? 'Deskripsi tidak tersedia'),
                          Text('URL: ${data['url'] ?? 'URL tidak tersedia'}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(_formatTime(data['time'])), // Perbarui di sini
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await _deleteTask(context, taskId);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Positioned(
          
            bottom: 70,
            right: 30,
            child: FloatingActionButton(
              onPressed: () {
                // Navigasi ke halaman TaskEditPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TaskEditPage()),
                );
              },
              backgroundColor: const Color.fromARGB(255, 103, 210, 106),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
