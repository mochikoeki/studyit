import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'jadwal.dart';
import 'tugas.dart';

// Model untuk tugas
class Task {
  final String time;
  final String teacher;
  final String title;
  final String description;

  Task({
    required this.time,
    required this.teacher,
    required this.title,
    required this.description,
  });

  // Membuat instance Task dari dokumen Firestore
  factory Task.fromFirestore(Map<String, dynamic> data) {
    return Task(
      time: data['time'] ?? '',
      teacher: data['teacher'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  HomeContentState createState() => HomeContentState();
}

class HomeContentState extends State<HomeContent> {
  final double buttonWidth = 166; // Ukuran tetap tombol (lebar)
  final double buttonHeight = 65; // Ukuran tetap tombol (tinggi)

  // Fungsi untuk mengubah waktu ke format relatif
  String _formatTime(String time) {
    final dateTime = DateTime.parse(time);
    return timeago.format(dateTime, locale: 'en');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20), // Memberikan jarak dari bagian atas
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Button 1 (Username)
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 144, 144, 144)
                              .withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        fixedSize: Size(buttonWidth, buttonHeight),
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 48.0, bottom: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Hi, User',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color.fromARGB(255, 127, 127, 127),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 1),
                              Text(
                                'NIS - 220101069',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    top: 12,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                        border: Border.all(
                          color: const Color.fromARGB(255, 138, 138, 138),
                          width: 1,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'lib/images/pp.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              // Button 2 (Schedule)
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 144, 144, 144)
                              .withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const JadwalPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 106, 195, 109),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        fixedSize: Size(buttonWidth, buttonHeight),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 40.0, top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Schedule',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 1),
                            Text(
                              'Upcoming Lesson',
                              style: TextStyle(
                                color: Color.fromARGB(139, 255, 255, 255),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 24,
                    top: 16,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: const Icon(
                        Icons.event,
                        color: Color.fromARGB(255, 224, 235, 219),
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              // Menambahkan pengurutan berdasarkan waktu secara menurun
              stream: FirebaseFirestore.instance
                  .collection('tugas')
                  .orderBy('time',
                      descending: true) // Urutkan berdasarkan waktu
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                      child: Text("Tidak ada tugas yang tersedia."));
                }
                final tugasList = snapshot.data!.docs
                    .map((doc) =>
                        Task.fromFirestore(doc.data() as Map<String, dynamic>))
                    .toList();

                return ListView.builder(
                  itemCount: tugasList.length,
                  itemBuilder: (context, index) {
                    Task task = tugasList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(49, 136, 136, 136),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 239, 239, 239),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.timelapse_rounded,
                                        size: 16,
                                        color:
                                            Color.fromARGB(255, 145, 145, 145),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        _formatTime(task.time),
                                        style: const TextStyle(
                                          fontFamily: "poppins",
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 148, 148, 148),
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 116, 88, 88),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        '   By ${task.teacher}',
                                        style: const TextStyle(
                                          fontFamily: "poppins",
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 220, 220, 220),
                                          fontSize: 9,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      const Icon(
                                        Icons.person,
                                        size: 14,
                                        color:
                                            Color.fromARGB(255, 220, 220, 220),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Judul tugas
                            Text(
                              task.title,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 85, 85, 85),
                                fontFamily: "Poppins",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            // Deskripsi kecil
                            Text(
                              task.description,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 22),
                            // Tombol Submit Assignment
                            SizedBox(
                              height: 45,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TugasPage(
                                        task:
                                            task, // Mengirim objek Task ke halaman TugasPage
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor:
                                      const Color.fromARGB(255, 101, 140, 104),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.assignment,
                                      size: 16,
                                      color: Color.fromARGB(235, 255, 255, 255),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Start Assignment',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(235, 255, 255, 255),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
