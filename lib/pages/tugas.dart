import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Untuk menggunakan clipboard
import 'package:studyit/pages/beranda.dart';
import 'package:timeago/timeago.dart' as timeago;

class TugasPage extends StatelessWidget {
  final Task task; // Objek Task yang akan diterima
  final double boxWidth; // Ukuran lebar box (dalam piksel)
  final EdgeInsetsGeometry padding; // Padding untuk dalam box

  const TugasPage({
    super.key,
    required this.task,
    this.boxWidth = double.infinity, // Nilai default untuk lebar box
    this.padding = const EdgeInsets.all(16.0), // Nilai default untuk padding
  });

  // Fungsi untuk menyalin URL ke clipboard dengan BuildContext sebagai parameter
  void _copyToClipboard(BuildContext context, String url) async {
    await Clipboard.setData(ClipboardData(text: url));

    // Periksa apakah widget masih terpasang (mounted) sebelum menampilkan SnackBar
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('URL berhasil disalin ke clipboard!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mengonversi waktu menjadi format relatif (seperti "1 hour ago")
    String formattedTime = timeago.format(DateTime.parse(task.time));

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
        title: const Text('Detail Tugas'),
        centerTitle: false,
        actions: const [
          Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                Text(
                  'Detail Tugas',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 80, 146, 83),
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.library_books,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Membungkus konten agar dapat digulir
          child: Container(
            width: boxWidth, // Menggunakan boxWidth yang dapat diubah
            decoration: BoxDecoration(
              color: Colors.white, // Background putih untuk box
              borderRadius: BorderRadius.circular(16), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(212, 171, 171, 171).withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: padding, // Menggunakan padding yang dapat diubah
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Box abu-abu untuk By: Teacher dan waktu relatif
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Warna latar belakang abu-abu
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Nama guru di kiri
                      Text(
                        'By: ${task.teacher}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      // Waktu relatif di kanan
                      Text(
                        formattedTime, // Menampilkan waktu relatif
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Judul tugas di tengah, tebal
                Text(
                  task.title,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                // Deskripsi tugas
                Text(
                  task.description, // Menampilkan deskripsi tugas
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    height: 1.5, // Memberikan jarak antar baris untuk deskripsi
                  ),
                ),
                const SizedBox(height: 20),

                // Menampilkan URL yang diambil dari Firestore
                Text(
                  task.url, // Menampilkan URL
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    decoration: TextDecoration.underline, // Garis bawah pada URL
                  ),
                ),
                const SizedBox(height: 20),

                // Button "Copy Link" untuk menyalin URL ke clipboard
                ElevatedButton(
                  onPressed: () {
                    _copyToClipboard(context, task.url);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Set button color to green
                    elevation: 0, // Remove shadow
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Keep rounded corners
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12), // Vertical padding
                    minimumSize: const Size(double.infinity,
                        50), // Full width button with fixed height
                  ),
                  child: const Text(
                    'Copy Link',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
