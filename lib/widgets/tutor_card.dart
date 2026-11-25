import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/tutor.dart';
import '../utils/locale_provider.dart';
import '../utils/translations.dart';

class TutorCard extends StatelessWidget {
  final Tutor tutor;
  const TutorCard({super.key, required this.tutor});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LocaleProvider>().languageCode;
    final modeText = tutor.modes
        .map((m) => AppTranslations.t(lang, m == 'online' ? 'online' : 'face_to_face'))
        .join(' / ');
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(tutor.name.isNotEmpty ? tutor.name[0] : '?'),
        ),
        title: Text(tutor.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tutor.district),
            Text(modeText),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 18),
            Text(tutor.rating.toStringAsFixed(1)),
          ],
        ),
      ),
    );
  }
}