import 'package:flutter/material.dart';
import 'news_detail.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  EventPageState createState() => EventPageState();
}

class EventPageState extends State<EventPage> {
  String selectedFilter = 'All';

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
    {
      'image': 'lib/images/sampul.jpg',
      'title': 'Poster Event C',
      'description': 'Artikel ketiga menjelaskan hal yang berbeda...'
    },
    {
      'image': 'lib/images/sampul2.jpg',
      'title': 'Poster Event D',
      'description': 'Artikel ini menampilkan event yang menarik...'
    },
    {
      'image': 'lib/images/artikel.jpg',
      'title': 'Poster Event C',
      'description': 'Deskripsi artikel pertama yang berbeda dari yang lain...'
    },
    {
      'image': 'lib/images/artikel.jpg',
      'title': 'Poster Event Zero',
      'description': 'Deskripsi artikel pertama yang berbeda dari yang lain...'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // Wrap with SingleChildScrollView
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
                  isSelected: selectedFilter == 'Article',
                  onTap: () => setState(() => selectedFilter = 'Article'),
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

            // Article/Event Cards (Using GridView for 2 columns per row)
            GridView.builder(
  physics: const NeverScrollableScrollPhysics(), // Disable scroll for GridView
  shrinkWrap: true, // Allow GridView to take only the required space
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2, // 2 items per row
    crossAxisSpacing: 16.0,
    mainAxisSpacing: 8.0,
    childAspectRatio: 0.75, // Adjust the aspect ratio as needed
  ),
  itemCount: articles.length,
  itemBuilder: (context, index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailNewsPage(
              imagePath: articles[index]['image']!,
              title: articles[index]['title']!,
              description: articles[index]['description']!,
            ),
          ),
        );
      },
      child: StackCard(
        imagePath: articles[index]['image']!,
        title: articles[index]['title']!,
        description: articles[index]['description']!,
      ),
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
          backgroundColor: isSelected ? const Color.fromARGB(255, 106, 195, 109) : Colors.white,
          foregroundColor: isSelected ? Colors.white : const Color.fromARGB(255, 163, 46, 46),
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

// StackCard widget to allow flexibility with image and text overlay
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
            child: Image.asset(
              imagePath,
              height: double.infinity, // Fill the height
              width: double.infinity,   // Fill the width
              fit: BoxFit.cover,        // Ensure image fills the box and maintains aspect ratio
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
                    Color.fromARGB(57, 0, 0, 0),  // Near black at the bottom
                    Colors.transparent,  // Transparent at the top
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
                  description,
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
