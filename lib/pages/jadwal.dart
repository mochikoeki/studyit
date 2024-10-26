import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Untuk File

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  JadwalPageState createState() => JadwalPageState();
}

class JadwalPageState extends State<JadwalPage> {
  File? _image; // Variabel untuk menyimpan file gambar
  double? _imageWidth; // Lebar asli gambar
  double? _imageHeight; // Tinggi asli gambar

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        // Mendapatkan ukuran asli gambar
        _getImageSize(_image!);
      });
    }
  }

  // Fungsi untuk mendapatkan ukuran asli dari gambar yang dipilih
  Future<void> _getImageSize(File image) async {
    final decodedImage = await decodeImageFromList(image.readAsBytesSync());
    setState(() {
      _imageWidth = decodedImage.width.toDouble();
      _imageHeight = decodedImage.height.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Mengubah ikon back button
        leading: IconButton(
          iconSize: 16,
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color.fromARGB(
                  255, 106, 195, 109)), // Ganti ikon dan warna di sini
          onPressed: () {
            Navigator.pop(context); // Aksi untuk kembali ke halaman sebelumnya
          },
        ),
        title: const Text('Jadwal'),
        centerTitle: false, // Agar judul tidak di tengah
        actions: const [
          Spacer(), // Menambahkan spacer untuk meratakan teks ke kanan
          Padding(
            padding: EdgeInsets.only(
                right: 20.0), // Menambahkan padding di sebelah kanan
            child: Row(
              children: [
                Text(
                  'Jadwal',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 80, 146, 83), // Warna teks
                  ),
                ),
                SizedBox(width: 8), // Jarak antara teks dan ikon
                Icon(
                  Icons.event, // Ikon yang ingin ditampilkan
                  color: Color.fromARGB(255, 80, 146, 83), // Warna ikon
                ),
              ],
            ),
          ),
        ],
        backgroundColor: Colors.white, // Ganti warna AppBar
        elevation: 0, // Menghapus shadow bawaan AppBar
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(1.0), // Ukuran height dari border
          child: Container(
            color: const Color.fromARGB(39, 0, 0, 0), // Warna border hitam
            height: 1.0, // Ketebalan border
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _pickImage, // Fungsi saat kotak besar diklik
                child: _image != null &&
                        _imageWidth != null &&
                        _imageHeight != null
                    ? LayoutBuilder(
                        builder: (context, constraints) {
                          double maxWidth =
                              constraints.maxWidth; // Lebar layar yang tersedia
                          double aspectRatio =
                              _imageWidth! / _imageHeight!; // Rasio asli gambar
                          double imageHeight = maxWidth /
                              aspectRatio; // Menyesuaikan tinggi berdasarkan lebar dan rasio

                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _image!,
                              width: maxWidth,
                              height:
                                  imageHeight, // Menggunakan tinggi yang sesuai dengan rasio
                              fit: BoxFit.contain, // Gambar tidak dipotong
                            ),
                          );
                        },
                      )
                    : Container(
                        width: double.infinity,
                        height: 400, // Tinggi tetap jika belum ada gambar
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // Menghilangkan border dan menambahkan shadow
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.2), // Warna shadow
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 2), // Posisi shadow
                            ),
                          ],
                          color: Colors.white, // Warna background
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.upload_file_rounded,
                              size: 30,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Upload\nJPG/PNG File',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              const SizedBox(height: 40),
              const Text.rich(
                TextSpan(
                  text: 'Note : ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          'Minta jadwal pada staff kemudian upload file', // Bagian teks regular
                      style: TextStyle(
                        fontWeight: FontWeight
                            .normal, // Mengatur teks selanjutnya menjadi regular
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
