import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_theme.dart';
import '../../utils/locale_provider.dart';

class HelpCentreScreen extends StatelessWidget {
  const HelpCentreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LocaleProvider>().languageCode;
    return Scaffold(
      appBar: AppBar(title: Text(lang == 'en' ? 'Help Centre' : 'Pusat Bantuan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.email, color: AppColors.primary),
            title: const Text('Email Support'),
            subtitle: const Text('support@smartstudy.com'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.phone, color: AppColors.primary),
            title: const Text('Phone Support'),
            subtitle: const Text('+60 12-345 6789'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.chat, color: AppColors.primary),
            title: const Text('Live Chat'),
            subtitle: Text(lang == 'en' ? 'Available 9am - 5pm' : 'Tersedia 9am - 5pm'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}