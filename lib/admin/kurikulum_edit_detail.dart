import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditKurikulumDetailPage extends StatefulWidget {
  final String title;
  final String description;

  const EditKurikulumDetailPage(
      {super.key, required this.title, required this.description});

  @override
  EditKurikulumDetailPageState createState() =>
      EditKurikulumDetailPageState();
}

class EditKurikulumDetailPageState extends State<EditKurikulumDetailPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _updateDescription() async {
    try {
      await FirebaseFirestore.instance.collection('kurikulum').doc('kelas_deskripsi').update({
        widget.title == 'Kelas 7' ? 'kelas_7' :
        widget.title == 'Kelas 8' ? 'kelas_8' : 'kelas_9': _controller.text,
      });

      // Cek apakah widget masih terpasang sebelum menggunakan BuildContext
      if (mounted) {
        Navigator.pop(context); // Kembali setelah berhasil
      }
    } catch (e) {
      // Cek apakah widget masih terpasang sebelum menampilkan Snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal mengupdate deskripsi')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Deskripsi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: widget.title,
                border: const OutlineInputBorder(),
              ),
              maxLines: 15, // Meningkatkan jumlah baris untuk menampung lebih banyak teks
              keyboardType: TextInputType.multiline, // Memungkinkan penulisan baris baru
              textInputAction: TextInputAction.newline, // Membuka baris baru saat tombol enter ditekan
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateDescription,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 96, 183, 99),
              ),
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
