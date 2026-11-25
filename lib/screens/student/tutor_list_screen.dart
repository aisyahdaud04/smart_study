import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/subject.dart';
import '../../models/tutor.dart';
import '../../services/firestore_service.dart';
import '../../utils/app_theme.dart';
import '../../utils/locale_provider.dart';
import '../../utils/translations.dart';
import '../../widgets/tutor_card.dart';
import 'tutor_detail_screen.dart'; // <-- Import screen detail

class TutorListScreen extends StatefulWidget {
  final Subject subject;
  const TutorListScreen({super.key, required this.subject});

  @override
  State<TutorListScreen> createState() => _TutorListScreenState();
}

class _TutorListScreenState extends State<TutorListScreen> {
  final _service = FirestoreService();
  String? _mode;
  String? _district;
  late Future<List<Tutor>> _future;

  final _districts = ['Shah Alam', 'Petaling', 'Klang', 'Gombak', 'Sepang'];

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    setState(() {
      _future = _service.getTutors(
        subjectId: widget.subject.id,
        mode: _mode,
        district: _district,
      );
    });
  }

  void _clearFilters() {
    setState(() {
      _mode = null;
      _district = null;
      _reload();
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LocaleProvider>().languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject.name),
      ),
      body: Column(
        children: [
          // ================= FILTER SECTION =================
          Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.filter_alt_outlined,
                        color: AppColors.primary, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      lang == 'en' ? 'Filter Tutors' : 'Tapis Tutor',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    const Spacer(),
                    if (_mode != null || _district != null)
                      TextButton.icon(
                        onPressed: _clearFilters,
                        icon: const Icon(Icons.clear, size: 16),
                        label: Text(
                          lang == 'en' ? 'Clear' : 'Kosongkan',
                          style: const TextStyle(fontSize: 12),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          minimumSize: const Size(0, 32),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    // MODE FILTER
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _mode,
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: AppTranslations.t(lang, 'mode'),
                          prefixIcon: const Icon(Icons.computer, size: 18),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'online',
                            child: Text(AppTranslations.t(lang, 'online'),
                                overflow: TextOverflow.ellipsis),
                          ),
                          DropdownMenuItem(
                            value: 'faceToFace',
                            child: Text(AppTranslations.t(lang, 'face_to_face'),
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                        onChanged: (v) {
                          _mode = v;
                          _reload();
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    // DISTRICT FILTER
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _district,
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: AppTranslations.t(lang, 'district'),
                          prefixIcon:
                              const Icon(Icons.location_on_outlined, size: 18),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                        ),
                        items: _districts
                            .map((d) => DropdownMenuItem(
                                  value: d,
                                  child: Text(d, overflow: TextOverflow.ellipsis),
                                ))
                            .toList(),
                        onChanged: (v) {
                          _district = v;
                          _reload();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ================= RESULT SECTION =================
          Expanded(
            child: FutureBuilder<List<Tutor>>(
              future: _future,
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
                final tutors = snap.data ?? [];
                if (tutors.isEmpty) {
                  return Center(
                    child: Text(AppTranslations.t(lang, 'no_tutors')),
                  );
                }

                return RefreshIndicator(
                  color: AppColors.primary,
                  onRefresh: () async {
                    _reload();
                    await _future;
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    itemCount: tutors.length,
                    itemBuilder: (_, i) {
                      final tutor = tutors[i];
                      // TUKAR SINI: Bungkus TutorCard dengan GestureDetector/InkWell
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TutorDetailScreen(
                                tutor: tutor,
                                subjectId: widget.subject.id,     // <-- Hantar ID Subjek
                                subjectName: widget.subject.name, // <-- Hantar Nama Subjek
                              ),
                            ),
                          );
                        },
                        child: TutorCard(tutor: tutor),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}