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

  void _login() {
    String email = emailController.text;
    String password = passwordController.text;

    String? role;
    if (email == "admin" && password == "a") {
      role = "admin";
    } else if (email == "user" && password == "u") {
      role = "user";
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login gagal. Periksa email dan password.')),
      );
      return;
    }

    Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => BasePage(role: role), // Melewatkan nilai role yang benar
  ),
);

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
                // Gambar dan deskripsi di bagian atas
                _buildHeader(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
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
                      const SizedBox(height: 40),
                      _buildSocialLoginDivider(),
                      const SizedBox(height: 30),
                      _buildSocialLoginButtons(),
                      const SizedBox(height: 50),
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
    );
  }

  Widget _buildSocialLoginDivider() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 80, height: 1, color: Colors.grey[400]),
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
          Container(width: 80, height: 1, color: Colors.grey[400]),
        ],
      ),
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          onPressed: () {},
          assetPath: 'lib/images/google.png',
          label: 'Google',
        ),
        const SizedBox(width: 20),
        _buildSocialButton(
          onPressed: () {},
          assetPath: 'lib/images/fb.png',
          label: 'Facebook',
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required VoidCallback onPressed,
    required String assetPath,
    required String label,
  }) {
    return SizedBox(
      width: 140,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Image.asset(assetPath, width: 24, height: 24),
        label: Text(
          label,
          style: const TextStyle(
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
