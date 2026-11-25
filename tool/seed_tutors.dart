import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import '../lib/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final db = FirebaseFirestore.instance;

  // ============================================================
  // 60 ENGLISH TUTOR NAMES
  // ============================================================
  final names = [
    'Sir Nizam', 'Madam Aisyah', 'Mr. Lee', 'Ms. Priya', 'Madam Fatimah',
    'Mr. Kumar', 'Ms. Nurul', 'Mr. Tan', 'Madam Sofia', 'Sir Hafiz',
    'Ms. Mei Ling', 'Sir Faizal', 'Ms. Devi', 'Mr. Syafiq', 'Madam Aina',
    'Sir Daniel', 'Madam Hana', 'Mr. Zul', 'Ms. Farah', 'Sir Imran',
    'Madam Wani', 'Mr. Ikmal', 'Ms. Suraya', 'Sir Amir', 'Madam Lina',
    'Mr. Hakim', 'Ms. Sofia', 'Sir Danial', 'Madam Yasmin', 'Mr. Azlan',
    'Ms. Mei', 'Sir Rizal', 'Madam Nadia', 'Mr. Faiz', 'Ms. Iman',
    'Sir Haris', 'Madam Balqis', 'Mr. Kamal', 'Ms. Nisa', 'Sir Irfan',
    'Madam Alya', 'Mr. Aziz', 'Ms. Huda', 'Sir Syahmi', 'Madam Alia',
    'Mr. Rahim', 'Ms. Mira', 'Sir Haziq', 'Madam Sofea', 'Mr. Luqman',
    'Ms. Amani', 'Sir Firdaus', 'Madam Aisy', 'Mr. Afiq', 'Ms. Nabila',
    'Sir Hakimi', 'Madam Zahra', 'Mr. Danish', 'Ms. Qistina', 'Sir Rayyan',
  ];

  final subjects = [
    'math', 'addmath', 'physics', 'chemistry',
    'biology', 'bm', 'english', 'sejarah',
  ];

  final districts = ['Shah Alam', 'Petaling', 'Klang', 'Gombak', 'Sepang'];
  final modes = ['online', 'faceToFace'];

  final bios = [
    '5 years of experience teaching SPM students.',
    'UPSI graduate, focused on exam answering techniques.',
    'Relaxed but effective teaching approach.',
    'Uses concise notes and intensive practice.',
    'Helps weak students improve their grades.',
    'Teaches step-by-step until students understand.',
    'Uses visual techniques for difficult topics.',
    'Committed to helping students score A.',
    'Specializes in building strong fundamentals.',
    'Patient and attentive to each student\'s pace.',
    'Focuses on past-year SPM question analysis.',
    'Uses real-life examples to explain concepts.',
  ];

  // ============================================================
  // STEP 1: CHECK & FIX EXISTING TUTORS
  // ============================================================
  print('🔍 Checking existing tutors...');
  final existingSnap = await db.collection('tutors').get();
  final existingNames = <String>{};
  int skipped = 0;
  int added = 0;
  int normalized = 0;

  for (final doc in existingSnap.docs) {
    final data = doc.data();
    final name = (data['name'] as String? ?? '').trim();
    if (name.isEmpty) continue;
    existingNames.add(name.toLowerCase());

    final updates = <String, dynamic>{};

    // subjects: string -> array
    final subj = data['subjects'];
    if (subj is String) {
      updates['subjects'] = [subj];
    } else if (subj == null) {
      updates['subjects'] = <String>[];
    }

    // mode (no s) -> modes (array)
    if (data.containsKey('mode') && !data.containsKey('modes')) {
      final oldMode = data['mode'];
      updates['modes'] = oldMode is String ? [oldMode] : <String>[];
      updates['mode'] = FieldValue.delete();
    }
    final m = data['modes'];
    if (m is String) {
      updates['modes'] = [m];
    }

    if (data['rating'] is! num) updates['rating'] = 0.0;
    if (data['totalReviews'] is! num) updates['totalReviews'] = 0;
    if (data['bio'] == null) updates['bio'] = 'SmartStudy tutor.';
    if (data['district'] == null) updates['district'] = 'Shah Alam';
    if (data['email'] == null) updates['email'] = '';
    if (data['phone'] == null) updates['phone'] = '';

    if (updates.isNotEmpty) {
      await doc.reference.update(updates);
      normalized++;
      print('   🔧 ${data['name']} - format fixed');
    }
  }

  print('✅ Found ${existingNames.length} existing tutor(s).');
  if (normalized > 0) {
    print('🔧 $normalized tutor(s) normalized.');
  }
  print('');

  // ============================================================
  // STEP 2: ADD NEW TUTORS (SKIP EXISTING)
  // ============================================================
  print('🚀 Adding new tutors...');
  final random = Random(42); // fixed seed = consistent results

  for (int i = 0; i < names.length; i++) {
    final name = names[i];

    if (existingNames.contains(name.toLowerCase())) {
      skipped++;
      print('⏭️  ${i + 1}/60 - $name (skip, exists)');
      continue;
    }

    // 1-3 random subjects
    final numSubjects = 1 + random.nextInt(3);
    final tutorSubjects = <String>{};
    while (tutorSubjects.length < numSubjects) {
      tutorSubjects.add(subjects[random.nextInt(subjects.length)]);
    }

    // 1-2 random modes
    final tutorModes = <String>{};
    final numModes = 1 + random.nextInt(2);
    while (tutorModes.length < numModes) {
      tutorModes.add(modes[random.nextInt(modes.length)]);
    }

    final doc = <String, dynamic>{
      'name': name,
      'email': 'tutor${i + 1}@smartstudy.com',
      'phone': '01${random.nextInt(90000000) + 10000000}',
      'subjects': tutorSubjects.toList(),
      'modes': tutorModes.toList(),
      'district': districts[random.nextInt(districts.length)],
      'bio': bios[random.nextInt(bios.length)],
      'rating': double.parse(
          (3.5 + random.nextDouble() * 1.5).toStringAsFixed(1)),
      'totalReviews': random.nextInt(50),
    };

    await db.collection('tutors').add(doc);
    existingNames.add(name.toLowerCase());
    added++;
    print('➕ ${i + 1}/60 - $name (${tutorSubjects.join(', ')})');
  }

  // ============================================================
  // STEP 3: FINAL REPORT
  // ============================================================
  final finalCount = (await db.collection('tutors').get()).docs.length;

  print('');
  print('═══════════════════════════════════════════');
  print('✅ DONE');
  print('   ➕ Added    : $added');
  print('   ⏭️  Skipped  : $skipped');
  print('   🔧 Fixed    : $normalized');
  print('   📊 Total tutors in Firestore: $finalCount');
  print('═══════════════════════════════════════════');
}