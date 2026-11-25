import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/subject.dart';
import '../../services/firestore_service.dart';
import '../../utils/locale_provider.dart';
import '../../utils/translations.dart';
import '../../widgets/language_toggle.dart';
import 'tutor_list_screen.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LocaleProvider>().languageCode;
    final service = FirestoreService();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTranslations.t(lang, 'choose_subject')),
        actions: const [LanguageToggle()],
      ),
      body: FutureBuilder<List<Subject>>(
        future: service.getSubjects(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(
              child: Text(
                  '${AppTranslations.t(lang, 'error_loading')}: ${snap.error}'),
            );
          }
          final subjects = snap.data ?? [];
          if (subjects.isEmpty) {
            return Center(child: Text(AppTranslations.t(lang, 'no_subjects')));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
            ),
            itemCount: subjects.length,
            itemBuilder: (_, i) {
              final s = subjects[i];
              return Card(
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TutorListScreen(subject: s),
                    ),
                  ),
                  child: Center(
                    child: Text(s.name, textAlign: TextAlign.center),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}