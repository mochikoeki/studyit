import 'package:flutter/material.dart';

class KurmerPage extends StatelessWidget {
  const KurmerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kurikulum Merdeka"),
      ),
      body: const Center(
        child: Text("Penjelasan detail tentang Kurikulum Merdeka."),
      ),
    );
  }
}
