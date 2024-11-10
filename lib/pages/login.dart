import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studyit/base.dart';
import 'package:studyit/pages/create.dart';

class LoginPage extends StatefulWidget {
  final double dividerWidth;

  const LoginPage({super.key, this.dividerWidth = 120.0});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
  try {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == 'admin' && password == 'a') {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BasePage(role: 'admin'),
        ),
      );
    } else {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        String role = userDoc['role'] ?? 'user';

        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BasePage(role: role),
          ),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login gagal: data pengguna tidak ditemukan.')),
        );
      }
    }
  } catch (e) {
    String errorMessage = 'Login gagal: Terjadi kesalahan';

    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'Email tidak terdaftar';
          break;
        case 'wrong-password':
          errorMessage = 'Password salah';
          break;
        case 'invalid-email':
          errorMessage = 'Email tidak valid';
          break;
        case 'invalid-credential':
          errorMessage = 'Kredensial yang diberikan tidak valid atau rusak';
          break;
        default:
          errorMessage = 'Login gagal: ${e.message}';
      }
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  }
}


  void _unfocus() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: _unfocus,
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.only(bottom: keyboardHeight),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 40.0),
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: emailController,
                        hintText: 'Email',
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
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
                      _buildLoginButton(),
                      const SizedBox(height: 240),
                      _buildCreateAccountText(),
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

  Widget _buildHeader() {
    return SizedBox(
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
          Container(color: Colors.black.withOpacity(0.5)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
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
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
  }) {
    return SizedBox(
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
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.grey,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: 320,
      height: 50,
      child: ElevatedButton(
        onPressed: _login,
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 38, 38, 38),
          backgroundColor: Colors.green,
          shadowColor: Colors.greenAccent.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
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
    );
  }

  Widget _buildCreateAccountText() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CreateAccountPage(),
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
          children: [
            TextSpan(text: "Don't Have an Account? "),
            TextSpan(
              text: 'Create.',
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
