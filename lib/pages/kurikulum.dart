import 'package:flutter/material.dart';
import 'kurikulum_detail.dart'; // Import halaman detail
import 'kurmer.dart';

class KurikulumPage extends StatelessWidget {
  const KurikulumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.only(top: 30.0, right: 20, left: 20, bottom: 10),
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const KurikulumDetailPage(kelas: '7'),
              ),
            ),
            child: _buildKurikulumBox('Kelas 7', 'Deskripsi untuk Kelas 7', Icons.book),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const KurikulumDetailPage(kelas: '8'),
              ),
            ),
            child: _buildKurikulumBox('Kelas 8', 'Deskripsi untuk Kelas 8', Icons.book),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const KurikulumDetailPage(kelas: '9'),
              ),
            ),
            child: _buildKurikulumBox('Kelas 9', 'Deskripsi untuk Kelas 9', Icons.book),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const KurmerPage()),
            ),
            child: _buildKurikulumBox2('Apa itu Kurikulum Merdeka?', 'Penjelasan tentang Kurikulum Merdeka', Icons.info),
          ),
        ],
      ),
    );
  }


  // Widget untuk box kurikulum biasa
  Widget _buildKurikulumBox(String title, String description, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(66, 160, 160, 160),
            blurRadius: 4.0,
            offset: Offset(0, 2), // Posisi bayangan
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 121, 121, 121)
                  ),
                ),
                const SizedBox(height: 8), // Space between title and description
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8), // Space between text and icon
          Icon(
            icon,
            size: 40, // Ukuran ikon
            color: Colors.blue, // Warna ikon
          ),
        ],
      ),
    );
  }

  // Widget untuk box kurikulum dengan tampilan berbeda (Apa itu Kurikulum Merdeka)
  Widget _buildKurikulumBox2(String title, String description, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 111, 166, 210), // Warna biru gelap
            Color.fromARGB(255, 122, 203, 241), // Warna biru terang
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(66, 160, 160, 160),
            blurRadius: 4.0,
            offset: Offset(0, 2), // Posisi bayangan
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Ubah warna teks jika perlu
                  ),
                ),
                const SizedBox(height: 8), // Space between title and description
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70, // Ubah warna deskripsi jika perlu
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8), // Jarak antara teks dan ikon
          Icon(
            icon,
            size: 40, // Ukuran ikon
            color: Colors.white, // Ubah warna ikon jika perlu
          ),
        ],
      ),
    );
  }
}
