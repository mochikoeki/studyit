import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:studyit/base.dart';
import 'package:studyit/firebase_options.dart';
import 'package:studyit/pages/login.dart';

 void main() async { 
  WidgetsFlutterBinding.ensureInitialized(); 
await Firebase.initializeApp( 
    options: DefaultFirebaseOptions.currentPlatform, 
  ); 
  runApp(const MyApp()); 
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 0, 0)),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}