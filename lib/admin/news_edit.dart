import 'package:flutter/material.dart';
import 'news_add.dart'; // Import halaman news_add.dart

class NewsEdit extends StatefulWidget {
  const NewsEdit({super.key});

  @override
  NewsEditState createState() => NewsEditState();
}

class NewsEditState extends State<NewsEdit> {
  final List<Map<String, String>> articles = [
    {
      'image': 'lib/images/artikel.jpg',
      'title': 'Poster Event A',
      'description': 'Deskripsi artikel pertama yang berbeda dari yang lain...'
    },
    {
      'image': 'lib/images/event1.jpg',
      'title': 'Poster Event B',
      'description': 'Detail berita kedua ditampilkan disini...'
    },
  ];

  void _removeArticle(int index) {
    // Menghapus artikel berdasarkan index
    setState(() {
      articles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Edit News', style: TextStyle(
          fontFamily: "poppins",
          color: Color.fromARGB(255, 54, 122, 56),
          fontSize: 20
        )),
        actions: [
          IconButton(
            icon: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.only(left: 8), // Menambahkan padding
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0), // Menambahkan border radius
              ),
              child: const Icon(
                Icons.add,
                color: Colors.green, // Warna ikon
                size: 30.0, // Ukuran ikon
              ),
            ),
            onPressed: () {
              // Navigasi ke halaman tambah berita
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewsAdd()),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(
            color: const Color.fromARGB(40, 0, 0, 0),
            height: 0.7,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 12),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white, // Warna latar belakang Card
              borderRadius: BorderRadius.circular(8.0), // Menambahkan border radius
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(125, 87, 87, 87).withOpacity(0.1), // Warna bayangan
                  spreadRadius: 1, // Jarak sebar bayangan
                  blurRadius: 8, // Tingkat blur bayangan
                  offset: const Offset(0, 4), // Posisi bayangan di bawah Card
                ),
              ],
            ),
            child: SizedBox(
              height: 100, // Mengatur tinggi Card
              child: Center(
                child: ListTile(
                  leading: Image.asset(
                    articles[index]['image']!,
                    width: 50,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  title: Text(articles[index]['title']!),
                  subtitle: Text(articles[index]['description']!),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.green),
                    onPressed: () => _removeArticle(index), // Menghapus artikel saat tombol ditekan
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
