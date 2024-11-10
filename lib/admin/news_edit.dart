import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studyit/admin/news_add.dart';

class NewsEdit extends StatefulWidget {
  const NewsEdit({super.key});

  @override
  NewsEditState createState() => NewsEditState();
}

class NewsEditState extends State<NewsEdit> {
  List<Map<String, dynamic>> articles = [];

  @override
  void initState() {
    super.initState();
    _fetchArticles(); // Ambil artikel dari Firestore saat halaman pertama kali dibuka
  }

  // Fungsi untuk mengambil artikel dari Firestore
  Future<void> _fetchArticles() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('articles').get();
      if (mounted) {
        // Cek jika widget masih terpasang
        setState(() {
          articles = snapshot.docs.map((doc) {
            return {
              'id': doc.id, // Menyimpan ID artikel
              'image': doc['image'], // Menyimpan URL gambar
              'title': doc['title'], // Menyimpan judul
              'description': doc['description'], // Menyimpan deskripsi
            };
          }).toList();
        });
      }
    } catch (e) {
      if (mounted) {
        // Cek jika widget masih terpasang
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error fetching articles: $e')));
      }
    }
  }

  // Fungsi untuk menghapus artikel
  void _removeArticle(String articleId) async {
    try {
      await FirebaseFirestore.instance
          .collection('articles')
          .doc(articleId)
          .delete();
      if (mounted) {
        // Cek jika widget masih terpasang
        setState(() {
          articles.removeWhere((article) => article['id'] == articleId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Artikel berhasil dihapus')));
      }
    } catch (e) {
      if (mounted) {
        // Cek jika widget masih terpasang
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting article: $e')));
      }
    }
  }

  // Fungsi untuk memotong deskripsi menjadi 5 kata pertama
  String getShortDescription(String description) {
    List<String> words = description.split(' ');
    if (words.length > 5) {
      return '${words.sublist(0, 5).join(' ')}...'; // Menampilkan 5 kata pertama dengan '...'
    }
    return description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Edit News',
            style: TextStyle(
              fontFamily: "poppins",
              color: Color.fromARGB(255, 93, 174, 96),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.2,
            )),
        actions: [
          IconButton(
            icon: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.green,
                size: 30.0,
              ),
            ),
            onPressed: () {
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
      body: articles.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.only(top: 12),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(125, 87, 87, 87)
                            .withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: 100,
                    child: Center(
                      child: ListTile(
                        leading: Image.network(
                          articles[index]
                              ['image'], // Menampilkan gambar dari URL
                          width: 50,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        title: Text(articles[index]['title']),
                        subtitle: Text(getShortDescription(articles[index]
                            ['description'])), // Menampilkan deskripsi pendek
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.green),
                          onPressed: () =>
                              _removeArticle(articles[index]['id']),
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
