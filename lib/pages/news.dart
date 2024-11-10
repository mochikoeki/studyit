import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'news_detail.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  EventPageState createState() => EventPageState();
}

class EventPageState extends State<EventPage> {
  String selectedFilter = 'All';

  // Mengambil data artikel dari Firestore menggunakan StreamBuilder
  Stream<QuerySnapshot> getArticles() {
    // Filter artikel berdasarkan kategori (optional)
    if (selectedFilter == 'All') {
      return FirebaseFirestore.instance.collection('articles').snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('articles')
          .where('category',
              isEqualTo: selectedFilter
                  .toLowerCase()) // Pastikan cocok dengan kategori Firestore
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // Wrap with SingleChildScrollView
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FilterButton(
                  text: 'All',
                  isSelected: selectedFilter == 'All',
                  onTap: () => setState(() => selectedFilter = 'All'),
                ),
                FilterButton(
                  text: 'Event',
                  isSelected: selectedFilter == 'Event',
                  onTap: () => setState(() => selectedFilter = 'Event'),
                ),
                FilterButton(
                  text: 'Article',
                  isSelected: selectedFilter == 'Artikel',
                  onTap: () => setState(() => selectedFilter = 'Artikel'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Page Title
            const Text(
              'Artikel',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Artikel/Event Cards
            StreamBuilder<QuerySnapshot>(
              stream: getArticles(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('Tidak ada artikel.'));
                }

                final articles = snapshot.data!.docs;

                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    final imageUrl = article['image']; // URL gambar
                    final title = article['title']; // Judul artikel
                    final description =
                        article['description']; // Deskripsi artikel

                    return GestureDetector(
                      onTap: () {
                        // Tambahkan log untuk memastikan URL gambar
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailNewsPage(
                              imagePath: imageUrl,
                              title: title,
                              description: description,
                            ),
                          ),
                        );
                      },
                      child: StackCard(
                        imagePath: imageUrl,
                        title: title,
                        description: description,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isSelected
              ? const Color.fromARGB(255, 106, 195, 109)
              : Colors.white,
          foregroundColor: isSelected
              ? Colors.white
              : const Color.fromARGB(255, 163, 46, 46),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          side: const BorderSide(color: Color.fromARGB(255, 205, 205, 205)),
        ),
        child: Text(text),
      ),
    );
  }
}

class StackCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const StackCard({
    required this.imagePath,
    required this.title,
    required this.description,
    super.key,
  });

  String getShortDescription(String description) {
    List<String> words = description.split(' ');
    if (words.length > 4) {
      return '${words.sublist(0, 4).join(' ')}...';
    }
    return description;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0,
      child: Stack(
        children: [
          // Background Image
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              imagePath,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Gradient overlay
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black54,
                    Color.fromARGB(57, 0, 0, 0),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Text Overlay (Title and Description)
          Positioned(
            bottom: 20.0,
            left: 14.0,
            right: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  getShortDescription(description),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
