import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:studyit/admin/beranda_admin.dart';
import 'package:studyit/pages/beranda.dart';
import 'pages/kurikulum.dart';
import 'pages/news.dart';
import 'pages/menu.dart';

class BasePage extends StatefulWidget {
  final String role;

  const BasePage({super.key, String? role}) : role = role ?? 'user';

  @override
  State<BasePage> createState() => _BasePageState();
}


class _BasePageState extends State<BasePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  // Menentukan konten yang sesuai berdasarkan role
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();

    // Memeriksa role dan menentukan konten yang ditampilkan
    if (widget.role == "admin") {
      _widgetOptions = <Widget>[
        const BerandaAdmin(),
        const EventPage(),
        const KurikulumPage(),
        const MenuPage(),
      ];
    } else {
      _widgetOptions = <Widget>[
        const HomeContent(),
        const EventPage(),
        const KurikulumPage(),
        const MenuPage(),
      ];
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'StudyIt',
          style: TextStyle(
            color: Colors.green,
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(
              top: 16, left: 10, bottom: 12), // Mengatur padding untuk logo
          child: Image.asset('lib/images/logo.png'), // Ganti dengan path logo Anda
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(top: 16, right: 16, bottom: 12, left: 14),
            icon: ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Color.fromARGB(255, 106, 195, 109), // Ganti dengan warna yang Anda inginkan
                BlendMode.srcIn,
              ),
              child: Image.asset('lib/images/notif.png'),
            ),
            onPressed: () {
              // Tambahkan aksi di sini
            },
          ),
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(
            color: const Color.fromARGB(40, 0, 0, 0),
            height: 0.7,
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _widgetOptions,
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: GNav(
            backgroundColor: Colors.white,
            color: Colors.grey,
            activeColor: Colors.white,
            tabBackgroundColor: const Color.fromARGB(255, 106, 195, 109),
            gap: 18,
            padding: const EdgeInsets.all(16),
            duration: const Duration(milliseconds: 200), // Animasi transisi lebih cepat
            tabs: const [
              GButton(icon: Icons.home_rounded, text: 'Home'),
              GButton(icon: Icons.ballot_rounded, text: 'News'),
              GButton(icon: Icons.book, text: 'Curriculum'),
              GButton(icon: Icons.menu_rounded, text: 'Menu'),
            ],
            selectedIndex: _selectedIndex, // Menunjukkan halaman yang dipilih
            onTabChange: _onItemTapped, // Memperbarui indeks saat tab berubah
          ),
        ),
      ),
    );
  }
}
