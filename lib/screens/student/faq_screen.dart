import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_theme.dart';
import '../../utils/locale_provider.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LocaleProvider>().languageCode;
    final faqs = [
      {
        'q': lang == 'en' ? 'How to book a tutor?' : 'Macam mana nak book tutor?',
        'a': lang == 'en' ? 'Go to Search tab, select subject, choose a tutor and click Book.' : 'Pergi tab Cari, pilih subjek, pilih tutor dan klik Book.'
      },
      {
        'q': lang == 'en' ? 'How to make payment?' : 'Macam mana nak buat pembayaran?',
        'a': lang == 'en' ? 'Payment details will be shown after you book a tutor.' : 'Butiran pembayaran akan dipaparkan selepas anda book tutor.'
      },
      {
        'q': lang == 'en' ? 'Can I cancel a class?' : 'Boleh tak saya cancel kelas?',
        'a': lang == 'en' ? 'Yes, please contact support for cancellation.' : 'Boleh, sila hubungi sokongan untuk pembatalan.'
      },
    ];

    return Scaffold(
      appBar: AppBar(title: Text(lang == 'en' ? 'FAQs' : 'Soalan Lazim')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ExpansionTile(
              title: Text(faqs[index]['q']!, style: const TextStyle(fontWeight: FontWeight.w600)),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(faqs[index]['a']!),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}