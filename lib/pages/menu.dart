import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  MenuPageState createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> {
  bool isDarkMode = false; // Variabel untuk menyimpan status mode

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
        child: Column(
          children: [
            // Profile and Dark Mode Section (Top)
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Align both boxes to center
              children: [
                // Profile Section (Top Left)
                SizedBox(
                  width: 165, // Define the fixed width for both boxes
                  child: Container(
                    height:
                        180, // Ensure the height is the same for both containers
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 194, 194, 194).withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: const Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align content to left
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Doni Knalpot',
                          textAlign: TextAlign.left, // Align text to left
                          style: TextStyle(
                            color: Color.fromARGB(255, 85, 152, 87),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins', // Use Poppins font
                          ),
                        ),
                        Text(
                          'NIS - 220101069',
                          textAlign: TextAlign.left, // Align text to left
                          style: TextStyle(
                            color: Color.fromARGB(255, 155, 155, 155),
                            fontSize: 12,
                            fontFamily: 'Poppins', // Use Poppins font
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                // Day Mode Section (Top Right)
                SizedBox(
                  width: 165, // Same width as the profile box
                  child: Container(
                    height: 180, // Kurangi tinggi agar muat
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 124, 202, 126), // Warna hijau tua
                          Color.fromARGB(
                              255, 195, 242, 140), // Warna hijau cerah
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.nights_stay,
                            size: 60, color: Colors.white),
                        const SizedBox(
                            height: 20), // Kurangi jarak antara ikon dan teks
                        const Text(
                          'Day Mode',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                            height:
                                10), // Tambahkan jarak antara teks dan toggle
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isDarkMode = !isDarkMode; // Toggle status
                            });
                          },
                          child: Container(
                            width: 60, // Lebar toggle
                            height: 30, // Tinggi toggle
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: isDarkMode
                                  ? const Color.fromARGB(255, 77, 103, 78)
                                  : const Color.fromARGB(255, 110, 161,
                                      113), // Warna latar belakang
                              border: Border.all(
                                color: Colors.grey, // Warna border
                                width: 1, // Lebar border
                              ),
                            ),
                            child: Stack(
                              children: [
                                // Lingkaran tombol
                                AnimatedAlign(
                                  alignment: isDarkMode
                                      ? Alignment.centerRight
                                      : Alignment
                                          .centerLeft, // Posisi lingkaran
                                  duration: const Duration(milliseconds: 200),
                                  child: Container(
                                    width:
                                        22, // Ubah diameter lingkaran untuk memberi jarak
                                    height:
                                        22, // Ubah diameter lingkaran untuk memberi jarak
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white, // Warna lingkaran
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal:
                                            4), // Tambahkan margin untuk memberi jarak
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Bottom Section (Features)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Two small icon boxes with different icons
                Row(
                  children: [
                    _buildIconBox(Icons.admin_panel_settings), // Ikon web
                    const SizedBox(width: 10),
                    _buildIconBox(Icons.info_rounded), // Ikon petunjuk
                  ],
                ),
                // Rectangular box with icon and text
                _buildFeatureBox(),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 2.0, // Ketebalan garis
              width: 40.0, // Panjang garis
              color: const Color.fromARGB(255, 205, 205, 205), // Warna garis
              margin: const EdgeInsets.symmetric(
                  vertical: 10), // Margin atas dan bawah untuk memberi jarak
            ),
            const SizedBox(height: 20),

            // Buttons Section (Newly Added)
            Column(
              children: [
                _buildFeatureButton(Icons.people_alt_rounded, '   Student List'),
                const SizedBox(height: 10),
                _buildFeatureButton(Icons.account_circle_rounded, '   Teacher List'),
                const SizedBox(height: 10),
                _buildFeatureButton(Icons.help_center_rounded, '   FAQ'),
                const SizedBox(height: 10),
                _buildFeatureButton(Icons.info, '   About'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function for small icon boxes with a parameter for the icon
  Widget _buildIconBox(IconData icon) {
    return Container(
      width: 80,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 194, 194, 194).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Icon(icon,
            size: 30,
            color: const Color.fromARGB(
                255, 106, 195, 109)), // Use the passed icon
      ),
    );
  }

  // Function for the rectangular feature box
  Widget _buildFeatureBox() {
    return Container(
      width: 165, // Atur lebar sesuai kebutuhan
      height: 70, // Atur tinggi sesuai kebutuhan
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 194, 194, 194).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: const Row(
        children: [
          Icon(
            Icons.translate,
            color: Color.fromARGB(
                255, 116, 115, 115), // Ganti dengan warna yang diinginkan
          ),
          SizedBox(width: 10),
          Text(
            '    English     ',
            style: TextStyle(
              color: Color.fromARGB(255, 103, 103, 103),
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins', // Use Poppins font
            ),
          ),
          Icon(
            Icons.arrow_forward,
            color: Color.fromARGB(
                255, 109, 109, 109), // Ganti dengan warna yang diinginkan
          ),
        ],
      ),
    );
  }

  // Function for the feature buttons
  Widget _buildFeatureButton(IconData icon, String label) {
  return Container(
    width: double.infinity, // Agar tombol mengisi lebar
    height: 50, // Tinggi tombol
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 194, 194, 194).withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 3,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Padding( // Tambahkan Padding di sini
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Sesuaikan nilai padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon,
              size: 20,
              color: const Color.fromARGB(255, 106, 195, 109)), // Ikon tombol
          const SizedBox(width: 10), // Jarak antara ikon dan teks
          Text(
            label,
            style: const TextStyle(
              color: Color.fromARGB(255, 143, 143, 143),
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins', // Use Poppins font
            ),
          ),
        ],
      ),
    ),
  );
}

}
