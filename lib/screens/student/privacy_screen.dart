import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Text(
          'Kami mengambil serius tentang privasi anda. Data yang dikumpul termasuk nama, emel, dan nombor telefon anda hanya digunakan untuk tujuan pendidikan.\n\n'
          'Kami tidak akan berkongsi maklumat anda dengan pihak ketiga tanpa kebenaran.\n\n'
          'Untuk sebarang pertanyaan, hubungi support@smartstudy.com.',
          style: TextStyle(height: 1.5, fontSize: 14),
        ),
      ),
    );
  }
}