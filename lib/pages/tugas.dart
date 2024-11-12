import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Tambahkan ini untuk membuka URL di browser
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

  void _openLinkInBrowser(String url) async {
  Uri uri = Uri.parse(url);
  if (uri.scheme == 'http' || uri.scheme == 'https') {
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      throw 'Could not launch $url: $e';
    }
  } else {
    throw 'Invalid URL scheme: $url';
  }
}


  @override
  Widget build(BuildContext context) {
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
        child: SingleChildScrollView(
          child: Container(
            width: boxWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(212, 171, 171, 171).withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'By: ${task.teacher}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        formattedTime,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  task.title,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  task.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  task.url,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 20),

                // Tombol "View" untuk membuka URL di browser
                ElevatedButton(
                  onPressed: () {
                    _openLinkInBrowser(task.url);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12),
                    minimumSize: const Size(double.infinity,
                        50),
                  ),
                  child: const Text(
                    'View',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
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
