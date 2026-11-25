import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../utils/app_theme.dart';
import '../../utils/locale_provider.dart';
import '../auth/login_screen.dart';
import 'ai_chat_screen.dart';
import 'my_subjects_screen.dart';
import 'learning_history_screen.dart';
import 'my_reviews_screen.dart';
import 'class_calendar_screen.dart';
import 'payment_history_screen.dart';
import 'faq_screen.dart';
import 'help_centre_screen.dart';
import 'terms_screen.dart';
import 'privacy_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _user = FirebaseAuth.instance.currentUser;
  String _userName = 'Student';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    if (_user == null) return;
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .get();
      if (doc.exists && doc.data()?['name'] != null) {
        setState(() {
          _userName = doc.data()!['name'];
        });
      }
    } catch (e) {
      debugPrint('Error fetching user name: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Fungsi bantuan untuk tukar bahasa (Popup)
  void _showLanguagePicker(BuildContext context, String lang) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Text(
                lang == 'en' ? 'Select Language' : 'Pilih Bahasa',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Text('🇬🇧', style: TextStyle(fontSize: 24)),
                title: const Text('English'),
                trailing: lang == 'en' ? const Icon(Icons.check, color: AppColors.primary) : null,
                onTap: () {
                  context.read<LocaleProvider>().setLanguage('en');
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                leading: const Text('🇲🇾', style: TextStyle(fontSize: 24)),
                title: const Text('Bahasa Melayu'),
                trailing: lang == 'ms' ? const Icon(Icons.check, color: AppColors.primary) : null,
                onTap: () {
                  context.read<LocaleProvider>().setLanguage('ms');
                  Navigator.pop(ctx);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LocaleProvider>().languageCode;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        title: Text(
          lang == 'en' ? 'Profile' : 'Profil',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF7F9FC),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.language, color: AppColors.textDark),
            onPressed: () => _showLanguagePicker(context, lang),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ================= HEADER =================
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.grey[300],
                        child: const Icon(Icons.person, size: 40, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _userName,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _user?.email ?? 'No email',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // ================= BANNER AI =================
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AiChatScreen()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E5EF3),
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                          image: NetworkImage('https://img.freepik.com/free-vector/online-tutorials-concept_52683-37480.jpg?w=740'),
                          fit: BoxFit.cover,
                          opacity: 0.2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              lang == 'en' ? 'What do you\nwant to Know?' : 'Apa yang anda\nnak tahu?',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              lang == 'en' ? 'Ask your school questions to AI.' : 'Tanya soalan sekolah pada AI.',
                              style: const TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ================= STATUS =================
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F0FE),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: Color(0xFF1E5EF3)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lang == 'en' ? 'Active Student' : 'Pelajar Aktif',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E5EF3),
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                lang == 'en' ? 'Ready to learn!' : 'Sedia untuk belajar!',
                                style: const TextStyle(color: Color(0xFF1E5EF3), fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // ================= LEARNING =================
                  _buildSectionTitle(lang == 'en' ? 'Learning' : 'Pembelajaran'),
                  _buildMenuItem(
                    icon: Icons.book_outlined,
                    title: lang == 'en' ? 'My Subjects' : 'Subjek Saya',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MySubjectsScreen())),
                  ),
                  _buildMenuItem(
                    icon: Icons.history,
                    title: lang == 'en' ? 'Learning History' : 'Sejarah Pembelajaran',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningHistoryScreen())),
                  ),
                  _buildMenuItem(
                    icon: Icons.star_outline,
                    title: lang == 'en' ? 'My Reviews' : 'Ulasan Saya',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MyReviewsScreen())),
                  ),
                  const Divider(height: 32),

                  // ================= SCHEDULE =================
                  _buildSectionTitle(lang == 'en' ? 'Schedule' : 'Jadual'),
                  _buildMenuItem(
                    icon: Icons.calendar_today_outlined,
                    title: lang == 'en' ? 'Class Calendar' : 'Kalendar Kelas',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ClassCalendarScreen())),
                  ),
                  _buildMenuItem(
                    icon: Icons.payment,
                    title: lang == 'en' ? 'Payment History' : 'Sejarah Pembayaran',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentHistoryScreen())),
                  ),
                  const Divider(height: 32),

                  // ================= SUPPORT =================
                  _buildSectionTitle(lang == 'en' ? 'Support' : 'Sokongan'),
                  _buildMenuItem(
                    icon: Icons.help_outline,
                    title: lang == 'en' ? 'FAQs' : 'Soalan Lazim',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FaqScreen())),
                  ),
                  _buildMenuItem(
                    icon: Icons.support_agent,
                    title: lang == 'en' ? 'Help Centre' : 'Pusat Bantuan',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpCentreScreen())),
                  ),
                  const Divider(height: 32),

                  // ================= ABOUT =================
                  _buildSectionTitle(lang == 'en' ? 'About' : 'Perihal'),
                  _buildMenuItem(
                    icon: Icons.description_outlined,
                    title: lang == 'en' ? 'Terms & Conditions' : 'Terma & Syarat',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TermsScreen())),
                  ),
                  _buildMenuItem(
                    icon: Icons.privacy_tip_outlined,
                    title: lang == 'en' ? 'Privacy Policy' : 'Dasar Privasi',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyScreen())),
                  ),
                  const Divider(height: 32),

                  // ================= LANGUAGE & LOGOUT =================
                  _buildMenuItem(
                    icon: Icons.language,
                    title: lang == 'en' ? 'Language' : 'Bahasa',
                    onTap: () => _showLanguagePicker(context, lang),
                  ),
                  _buildMenuItem(
                    icon: Icons.logout,
                    title: lang == 'en' ? 'Logout' : 'Log Keluar',
                    textColor: Colors.redAccent,
                    iconColor: Colors.redAccent,
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      if (!context.mounted) return;
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // ================= VERSION =================
                  Center(
                    child: Text(
                      'v1.0.0 — SmartStudy',
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.textMuted,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? AppColors.textDark, size: 22),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: textColor ?? AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}