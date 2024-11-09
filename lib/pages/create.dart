import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Tambahkan ini untuk Firebase Authentication
import 'package:studyit/pages/login.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  CreateAccountPageState createState() => CreateAccountPageState();
}

class CreateAccountPageState extends State<CreateAccountPage> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _classFocusNode = FocusNode();
  final FocusNode _studentIdFocusNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();


  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;
  bool _isClassFocused = false;
  bool _isStudentIdFocused = false;

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
    _classFocusNode.addListener(() {
      setState(() {
        _isClassFocused = _classFocusNode.hasFocus;
      });
    });
    _studentIdFocusNode.addListener(() {
      setState(() {
        _isStudentIdFocused = _studentIdFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _classFocusNode.dispose();
    _studentIdFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _createAccount() async {
  try {
    // Membuat akun baru dengan Firebase Authentication
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );

    // Mengambil UID pengguna
    String userId = userCredential.user!.uid;

    // Menyimpan data tambahan ke Firestore
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'email': _emailController.text,
      'class': _classController.text, // Menggunakan controller untuk class
      'studentId': _studentIdController.text,
      'role': 'User', // Menggunakan controller untuk studentId
    });

    // Cek apakah widget masih ada sebelum menggunakan BuildContext
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Account created successfully")),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  } catch (e) {
    // Cek apakah widget masih ada sebelum menggunakan BuildContext
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed to create account: $e")),
    );
  }
}




  void _unfocus() {
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();
    _classFocusNode.unfocus();
    _studentIdFocusNode.unfocus();
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
                              'Create Your Account',
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
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
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
                            focusNode: _emailFocusNode,
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: _isEmailFocused ? null : 'Email',
                              hintStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                            onTap: () {
                              setState(() {
                                _isEmailFocused = true;
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Kolom password
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
                            focusNode: _passwordFocusNode,
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: _isPasswordFocused ? null : 'Password',
                              hintStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                            onTap: () {
                              setState(() {
                                _isPasswordFocused = true;
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Kolom class dan student ID (tetap sama)
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
                            controller: _classController,
                            focusNode: _classFocusNode,
                            decoration: InputDecoration(
                              hintText: _isClassFocused ? null : 'Class',
                              hintStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                            onTap: () {
                              setState(() {
                                _isClassFocused = true; // Memperbarui status saat mengetik
                              });
                            },
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Kolom ID Student
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
                            controller: _studentIdController,
                            focusNode: _studentIdFocusNode,
                            decoration: InputDecoration(
                              hintText: _isStudentIdFocused ? null : 'Student ID',
                              hintStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                            onTap: () {
                              setState(() {
                                _isStudentIdFocused = true; // Memperbarui status saat mengetik
                              });
                            },
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Tombol Create Account dengan fungsi _createAccount
                      SizedBox(
                        width: 320,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _createAccount,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color.fromARGB(255, 38, 38, 38),
                            backgroundColor: Colors.green,
                            shadowColor: Colors.greenAccent.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: const Text(
                            'Create Account',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),

                      // Teks untuk sudah memiliki akun
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
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
                              TextSpan(text: "Already have an Account? "),
                              TextSpan(
                                text: 'Login.',
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
