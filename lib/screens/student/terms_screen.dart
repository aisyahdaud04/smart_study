import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms & Conditions')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Text(
          '1. Penggunaan aplikasi ini tertakluk kepada terma dan syarat yang ditetapkan.\n\n'
          '2. SmartStudy tidak bertanggungjawab atas sebarang kerugian.\n\n'
          '3. Semua pembayaran adalah tertakluk kepada polisi pemulangan wang.\n\n'
          '4. Data peribadi anda dilindungi di bawah Akta Perlindungan Data Peribadi 2010.',
          style: TextStyle(height: 1.5, fontSize: 14),
        ),
      ),
    );
  }
}