import 'package:flutter/material.dart';
import 'package:studyit/base.dart';
import 'package:studyit/pages/create.dart';


class LoginPage extends StatefulWidget {
  final double dividerWidth; // Tambahkan parameter dividerWidth

  const LoginPage({super.key, this.dividerWidth = 120.0}); // Default 100.0

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;

  // Variabel untuk email dan password statis
  final String staticEmail = "user@example.com"; // Ganti dengan email yang diinginkan
  final String staticPassword = "password123"; // Ganti dengan password yang diinginkan

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      setState(() {
        _isEmailFocused = _emailFocusNode.hasFocus;
      });
    });
    _passwordFocusNode.addListener(() {
      setState(() {
        _isPasswordFocused = _passwordFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose(); // Dispose controller email
    _passwordController.dispose(); // Dispose controller password
    super.dispose();
  }

  void _unfocus() {
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();
  }

  void _login() {
    // Periksa email dan password
    if (_emailController.text == '' && _passwordController.text == '') {
      // Jika cocok, navigasi ke halaman Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BasePage ()), // Ganti dengan halaman Home Anda
      );
    } else {
      // Tampilkan pesan kesalahan jika tidak cocok
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false, // Matikan inset otomatis
      body: GestureDetector(
        onTap: _unfocus,
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.only(bottom: keyboardHeight),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Gambar di bagian atas
                SizedBox(
                  width: double.infinity,
                  height: 260,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'lib/images/signup.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              'Sign in To Your Account',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -1.0,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Lorem ipsum dolor sit amet',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
                  child: Column(
                    children: [
                      // Kolom email
                      SizedBox(
                        width: 320,
                        height: 50,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.060),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _emailController, // Menetapkan controller
                            focusNode: _emailFocusNode,
                            decoration: InputDecoration(
                              hintText: _isEmailFocused ? null : 'Email',
                              hintStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                            onTap: () {
                              setState(() {
                                _isEmailFocused =
                                    true; // Memperbarui status saat mengetik
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Kolom password
                      SizedBox(
                        width: 320,
                        height: 50, // Sesuaikan tinggi box password
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color: Colors.white, // Warna latar belakang
                            borderRadius: BorderRadius.circular(10.0), // Sudut
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.060),
                                spreadRadius: 2, // Jarak penyebaran bayangan
                                blurRadius: 5, // Seberapa kabur bayangan
                                offset: const Offset(0, 3), // Posisi bayangan
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _passwordController, // Menetapkan controller
                            focusNode: _passwordFocusNode,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText:
                                  _isPasswordFocused ? null : 'Password',
                              hintStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0),
                            ),
                            onTap: () {
                              setState(() {
                                _isPasswordFocused =
                                    true; // Memperbarui status saat mengetik
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Teks "Forget Password?"
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color.fromARGB(255, 82, 82, 82),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Tombol Login
                      SizedBox(
                        width: 320,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _login, // Panggil metode login
                          style: ElevatedButton.styleFrom(
                            foregroundColor:
                                const Color.fromARGB(255, 38, 38, 38),
                            backgroundColor: Colors.green,
                            shadowColor:
                                Colors.greenAccent.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Garis pembatas dengan teks "Or login with" yang di tengah
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center, // Rata tengah
                          children: [
                            // Garis kiri
                            Container(
                              width: 80,
                              height: 1,
                              color: Colors.grey[400],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Or login with',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            // Garis kanan
                            Container(
                              width: 80,
                              height: 1,
                              color: Colors.grey[400],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Tombol Google dan Facebook
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Pusatkan tombol
                        children: [
                          // Tombol Google
                          SizedBox(
                            width: 140,
                            height: 50,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // Tambahkan logika login dengan Google di sini
                              },
                              icon: Image.asset(
                                'lib/images/google.png', // Ganti dengan path logo Google
                                width: 24,
                                height: 24,
                              ),
                              label: const Text(
                                'Google',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          // Tombol Facebook
                          SizedBox(
                            width: 140,
                            height: 50,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // Tambahkan logika login dengan Facebook di sini
                              },
                              icon: Image.asset(
                                'lib/images/fb.png', // Ganti dengan path logo Facebook
                                width: 24,
                                height: 24,
                              ),
                              label: const Text(
                                'Facebook',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 50),

                      // Teks untuk membuat akun baru
                      GestureDetector(
                        onTap: () {
                          // Navigasi ke halaman Create Account
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateAccountPage(), // Ganti dengan halaman Create Account Anda
                            ),
                          );
                        },
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color.fromARGB(255, 82, 82, 82),
                              fontSize: 12,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: "Don't Have an Account? "),
                              TextSpan(
                                text: 'Create.',
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
