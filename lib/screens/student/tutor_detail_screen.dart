import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../models/tutor.dart';
import '../../utils/app_theme.dart';
import '../../utils/locale_provider.dart';

class TutorDetailScreen extends StatefulWidget {
  final Tutor tutor;
  final String subjectId;
  final String subjectName;

  const TutorDetailScreen({
    super.key,
    required this.tutor,
    required this.subjectId,
    required this.subjectName,
  });

  @override
  State<TutorDetailScreen> createState() => _TutorDetailScreenState();
}

class _TutorDetailScreenState extends State<TutorDetailScreen> {
  bool _isBooking = false;

  Future<void> _bookTutor() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => _isBooking = true);

    try {
      // Simpan data ke collection 'enrollments'
      await FirebaseFirestore.instance.collection('enrollments').add({
        'studentId': user.uid,
        'studentEmail': user.email,
        'subjectId': widget.subjectId,
        'subjectName': widget.subjectName,
        'tutorId': widget.tutor.id,
        'tutorName': widget.tutor.name,
        'status': 'Active',
        'enrolledAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      
      // Tunjuk mesej berjaya
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Berjaya! Subjek ini telah ditambah ke My Subjects.'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
      
      // Kembali ke page sebelum (Tutor List)
      Navigator.pop(context); 
      
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal book tutor: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) setState(() => _isBooking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LocaleProvider>().languageCode;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(lang == 'en' ? 'Tutor Details' : 'Butiran Tutor'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar Tutor
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary.withOpacity(0.2),
              child: Text(
                widget.tutor.name.isNotEmpty ? widget.tutor.name[0] : '?',
                style: const TextStyle(
                  fontSize: 40, 
                  fontWeight: FontWeight.bold, 
                  color: AppColors.primary
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Nama & Rating
            Text(
              widget.tutor.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  widget.tutor.rating.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 8),
                Text(
                  '(${widget.tutor.totalReviews} ${lang == 'en' ? 'reviews' : 'ulasan'})',
                  style: const TextStyle(color: AppColors.textMuted),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Kad Maklumat
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lang == 'en' ? 'About Tutor' : 'Tentang Tutor',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.tutor.bio,
                    style: const TextStyle(fontSize: 14, color: AppColors.textDark, height: 1.5),
                  ),
                  const Divider(height: 32),
                  
                  // Subject
                  _buildInfoRow(
                    icon: Icons.book_outlined,
                    title: lang == 'en' ? 'Subject' : 'Subjek',
                    value: widget.subjectName,
                  ),
                  const SizedBox(height: 12),
                  
                  // Location
                  _buildInfoRow(
                    icon: Icons.location_on_outlined,
                    title: lang == 'en' ? 'District' : 'Daerah',
                    value: widget.tutor.district,
                  ),
                  const SizedBox(height: 12),
                  
                  // Mode
                  _buildInfoRow(
                    icon: Icons.computer,
                    title: lang == 'en' ? 'Mode' : 'Mod',
                    value: widget.tutor.modes.map((m) => m == 'online' ? 'Online' : 'Face-to-Face').join(' / '),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Butang Book
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed: _isBooking ? null : _bookTutor,
                icon: _isBooking 
                    ? const SizedBox(
                        width: 20, height: 20, 
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                      )
                    : const Icon(Icons.book_online),
                label: Text(
                  _isBooking 
                      ? (lang == 'en' ? 'Booking...' : 'Sedang Book...') 
                      : (lang == 'en' ? 'Book This Tutor' : 'Book Tutor Ini'),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                  shadowColor: AppColors.primary.withOpacity(0.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String title, required String value}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 12),
        Text(
          '$title: ',
          style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textMuted),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark),
          ),
        ),
      ],
    );
  }
}