import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as path;

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  JadwalPageState createState() => JadwalPageState();
}

class JadwalPageState extends State<JadwalPage> {
  File? _image;
  double? _imageWidth;
  double? _imageHeight;
  String? _imageUrl; // URL untuk menyimpan gambar
  String? _imageDocId; // ID dokumen gambar lama
  bool _isLoading = true; // Menambahkan status loading

  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    _loadImageFromFirebase(); // Memuat gambar saat halaman diinisialisasi
  }

  Future<void> _loadImageFromFirebase() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('jadwalImages')
          .orderBy('uploadedAt', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          _imageUrl = snapshot.docs.first['url']; // Simpan URL gambar
          _imageDocId = snapshot.docs.first.id; // Simpan ID dokumen
          _isLoading = false; // Menandakan bahwa loading selesai
        });
      } else {
        setState(() {
          _isLoading = false; // Menandakan bahwa loading selesai meskipun tidak ada gambar
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false; // Menandakan bahwa loading selesai meskipun ada error
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _getImageSize(_image!);
      });

      // Hapus gambar lama dari Firestore
      if (_imageDocId != null) {
        await FirebaseFirestore.instance.collection('jadwalImages').doc(_imageDocId).delete();
      }

      await _uploadImageToFirebase(_image!); // Upload gambar ke Firebase Storage
    }
  }

  Future<void> _getImageSize(File image) async {
    final decodedImage = await decodeImageFromList(image.readAsBytesSync());
    setState(() {
      _imageWidth = decodedImage.width.toDouble();
      _imageHeight = decodedImage.height.toDouble();
    });
  }

  Future<void> _uploadImageToFirebase(File image) async {
    try {
      String fileName = path.basename(image.path);
      Reference storageRef = _storage.ref().child('jadwal/$fileName');

      await storageRef.putFile(image);

      String downloadURL = await storageRef.getDownloadURL();

      // Menambahkan gambar baru ke Firestore
      await FirebaseFirestore.instance.collection('jadwalImages').add({
        'url': downloadURL,
        'uploadedAt': DateTime.now(),
      });

      setState(() {
        _imageUrl = downloadURL; // Perbarui URL di state agar gambar tampil
        _imageDocId = null; // Reset ID dokumen setelah upload
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gambar berhasil diunggah')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal mengunggah gambar')),
        );
      }
    }
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
        title: const Text('Jadwal'),
        centerTitle: false,
        actions: const [
          Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                Text(
                  'Jadwal',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 80, 146, 83),
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.event,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: _isLoading // Menampilkan loading indicator
                    ? const Center(child: CircularProgressIndicator())
                    : (_image != null && _imageWidth != null && _imageHeight != null)
                        ? LayoutBuilder(
                            builder: (context, constraints) {
                              double maxWidth = constraints.maxWidth;
                              double aspectRatio = _imageWidth! / _imageHeight!;
                              double imageHeight = maxWidth / aspectRatio;

                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  _image!,
                                  width: maxWidth,
                                  height: imageHeight,
                                  fit: BoxFit.contain,
                                ),
                              );
                            },
                          )
                        : (_imageUrl != null
                            ? Image.network(_imageUrl!)
                            : Container(
                                width: double.infinity,
                                height: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  color: Colors.white,
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
                              )),
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
                      text: 'Minta jadwal pada staff kemudian upload file',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
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
