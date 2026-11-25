import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_theme.dart';
import '../../utils/locale_provider.dart';
import '../../utils/translations.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LocaleProvider>().languageCode;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- HEADER: Welcome & Logo ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lang == 'en' ? 'Welcome to' : 'Selamat Datang ke',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textMuted,
                        ),
                      ),
                      const Text(
                        'SMART STUDY',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 45,
                      height: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // --- BANNER / HERO CARD ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.school, color: Colors.white, size: 36),
                    const SizedBox(height: 12),
                    Text(
                      lang == 'en' ? 'Ready to learn today?' : 'Bersedia untuk belajar hari ini?',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lang == 'en' ? 'Find the best tutor for your subjects.' : 'Cari tutor terbaik untuk subjek anda.',
                      style: const TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // --- SECTION NEWS / EDUCATION ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    lang == 'en' ? 'Education News' : 'Berita Pendidikan',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    lang == 'en' ? 'See All' : 'Lihat Semua',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Kad berita
              _buildNewsCard(
                title: lang == 'en' 
                    ? 'New KSSM Syllabus Updates for 2026' 
                    : 'Kemas Kini Silibus KSSM Baharu 2026',
                source: 'Kementerian Pendidikan',
                date: '18 Nov 2026',
                imageUrl: 'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=500&q=80', // Placeholder
              ),
              const SizedBox(height: 12),
              _buildNewsCard(
                title: lang == 'en'
                    ? 'How to Score A+ in SPM Mathematics'
                    : 'Cara Dapat A+ dalam Matematik SPM',
                source: 'SmartStudy Blog',
                date: '15 Nov 2026',
                imageUrl: 'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=500&q=80', // Placeholder
              ),
              const SizedBox(height: 12),
              _buildNewsCard(
                title: lang == 'en'
                    ? 'Scholarship Opportunities for Form 5 Students'
                    : 'Peluang Biasiswa untuk Pelajar Tingkatan 5',
                source: 'Education Malaysia',
                date: '10 Nov 2026',
                imageUrl: 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=500&q=80', // Placeholder
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsCard({
    required String title,
    required String source,
    required String date,
    required String imageUrl,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Gambar Berita
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
            child: Image.network(
              imageUrl,
              width: 110,
              height: 110,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 110,
                height: 110,
                color: AppColors.primary.withOpacity(0.1),
                child: const Icon(Icons.image, color: AppColors.primary),
              ),
            ),
          ),
          // Teks Berita
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        source,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}