import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_theme.dart';
import '../../utils/locale_provider.dart';

class ClassCalendarScreen extends StatelessWidget {
  const ClassCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LocaleProvider>().languageCode;
    return Scaffold(
      appBar: AppBar(title: Text(lang == 'en' ? 'Class Calendar' : 'Kalendar Kelas')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_month, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(lang == 'en' ? 'No classes scheduled yet.' : 'Tiada kelas dijadualkan lagi.'),
          ],
        ),
      ),
    );
  }
}