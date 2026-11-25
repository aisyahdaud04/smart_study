import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_theme.dart';
import '../utils/locale_provider.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleProvider>();
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      tooltip: locale.isEnglish ? 'Language' : 'Bahasa',
      onSelected: (code) => context.read<LocaleProvider>().setLanguage(code),
      itemBuilder: (_) => const [
        PopupMenuItem(value: 'en', child: Text('English')),
        PopupMenuItem(value: 'ms', child: Text('Bahasa Melayu')),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.language, size: 20, color: AppColors.textDark),
            const SizedBox(width: 4),
            Text(
              locale.isEnglish ? 'EN' : 'MS',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}