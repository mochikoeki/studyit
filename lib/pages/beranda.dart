import 'package:flutter/material.dart';
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
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  HomeContentState createState() => HomeContentState();
}

class HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    const double buttonWidth = 166; // Ukuran tetap tombol (lebar)
    const double buttonHeight = 65; // Ukuran tetap tombol (tinggi)

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
                              .withOpacity(0.2), // Warna shadow
                          blurRadius: 5, // Blur shadow
                          offset: const Offset(0, 2), // Arah dan jarak shadow
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation:
                            0, // Tidak perlu shadow dari button itu sendiri
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        fixedSize: const Size(buttonWidth, buttonHeight),
                      ),
                      child: const Align(
                        // Pastikan konten di dalam ElevatedButton di-align kiri
                        alignment: Alignment
                            .centerLeft, // Set alignment dari keseluruhan konten button
                        child: Padding(
                          padding: EdgeInsets.only(left: 48.0, bottom: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Rata kiri dalam kolom
                            mainAxisSize:
                                MainAxisSize.min, // Menyusut sesuai konten
                            children: [
                              Text(
                                'Hi, User',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color.fromARGB(255, 127, 127, 127),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 1), // Jarak antara teks
                              Text(
                                'NIS - 220101069', // Teks kecil di bawah Username
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
                  // Icon lingkaran dengan posisi absolute
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
                          color: const Color.fromARGB(255, 138, 138,
                              138), // Ganti dengan warna border yang Anda inginkan
                          width:
                              1, // Ganti dengan ketebalan border yang Anda inginkan
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
              const SizedBox(width: 20), // Jarak antara kedua tombol

              // Button 2 (Schedule)
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 144, 144, 144)
                              .withOpacity(0.2), // Warna shadow
                          blurRadius: 5, // Blur shadow
                          offset: const Offset(0, 2), // Arah dan jarak shadow
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigasi ke halaman jadwal.dart
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const JadwalPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 106, 195, 109),
                        elevation: 0, // Hilangkan elevasi default button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        fixedSize: const Size(buttonWidth, buttonHeight),
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
                            SizedBox(height: 1), // Jarak antara teks
                            Text(
                              'Upcoming Lesson', // Teks kecil di bawah Schedule
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
                  // Icon lingkaran dengan posisi absolute
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
                        color: Color.fromARGB(255, 224, 235, 219), // Warna icon
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20), // Jarak antara tombol dan konten

          // Daftar konten yang akan muncul
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                Task task =
                    tasks[index]; // Ambil objek Task untuk index saat ini
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 16, left: 20, right: 20, bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(49, 136, 136, 136),
                          blurRadius: 8,
                          offset: Offset(0, 2), // Shadow ke bawah
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row untuk waktu dan nama pengirim
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Box untuk waktu
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 5),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 239, 239,
                                    239), // Warna latar belakang hijau muda
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.timelapse_rounded, // Ikon untuk waktu
                                    size: 16,
                                    color: Color.fromARGB(255, 145, 145, 145),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '${task.time}   ',
                                    style: const TextStyle(
                                      fontFamily: "poppins",
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 148, 148, 148),
                                      fontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Box untuk nama pengirim
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 116, 88,
                                    88), // Warna latar belakang abu-abu
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    '   By ${task.teacher}',
                                    style: const TextStyle(
                                      fontFamily: "poppins",
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 220, 220, 220),
                                      fontSize: 9,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.person, // Ikon untuk pengirim
                                    size: 14,
                                    color: Color.fromARGB(255, 220, 220, 220),
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
                          width: double.infinity, // Mengatur lebar penuh
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TugasPage(
                                      task: task), // Mengirim objek Task
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
                              mainAxisAlignment:
                                  MainAxisAlignment.center, // Rata tengah
                              mainAxisSize:
                                  MainAxisSize.min, // Ukuran minimum untuk Row
                              children: [
                                Icon(
                                  Icons.assignment,
                                  size: 16, // Ganti dengan ikon yang diinginkan
                                  color: Color.fromARGB(
                                      235, 255, 255, 255), // Warna ikon
                                ),
                                SizedBox(
                                    width: 8), // Jarak antara ikon dan teks
                                Text(
                                  'Start Assignment',
                                  style: TextStyle(
                                    color: Color.fromARGB(235, 255, 255, 255),
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
            ),
          ),
        ],
      ),
    );
  }

  List<Task> tasks = [
    Task(
        time: '6 m ago',
        teacher: 'Teacher A',
        title: 'TASK 1: Title task',
        description: 'Lorem ipsum...'),
    Task(
        time: '10 m ago',
        teacher: 'Teacher B',
        title: 'TASK 2: Title task',
        description: 'Lorem ipsum dolor...'),
    Task(
        time: '15 m ago',
        teacher: 'Teacher C',
        title: 'TASK 3: Title task',
        description: 'Lorem ipsum sit...'),
    Task(
        time: '20 m ago',
        teacher: 'Teacher D',
        title: 'TASK 4: Title task',
        description: 'Lorem ipsum dolor sit...'),
  ];
}
