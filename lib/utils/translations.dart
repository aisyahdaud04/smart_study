class AppTranslations {
  static const Map<String, Map<String, String>> _data = {
    'en': {
      // Splash
      'app_name': 'SmartStudy',
      'app_tagline': 'Find tutors, learn smarter',

      // Login
      'welcome_back': 'Welcome Back',
      'login_subtitle': 'Log in to continue learning',
      'email': 'Email',
      'password': 'Password',
      'login': 'Log In',
      'no_account': "Don't have an account? Register",
      'login_failed': 'Login failed',

      // Register
      'create_account': 'Create New Account',
      'register_subtitle': 'Join SmartStudy today',
      'full_name': 'Full Name',
      'phone': 'Phone Number',
      'register': 'Register',
      'register_failed': 'Registration failed',
      'register_title': 'Register Account',

      // Home
      'welcome_greeting': 'Welcome! 👋',
      'welcome_desc': 'Find your preferred tutor and start learning with confidence.',
      'start_here': 'Start Here',
      'find_tutor': 'Find Tutor',
      'find_tutor_desc': 'Select subject and filter tutors by location',
      'logout': 'Log out',

      // Subject
      'choose_subject': 'Choose Subject',
      'no_subjects': 'No subjects in database.',
      'error_loading': 'Error',

      // Tutor List
      'mode': 'Mode',
      'district': 'District',
      'online': 'Online',
      'face_to_face': 'Face to Face',
      'no_tutors': 'No tutors found.',
      'rating': 'Rating',

      // Language
      'language': 'Language',
      'english': 'English',
      'malay': 'Bahasa Melayu',
    },
    'ms': {
      // Splash
      'app_name': 'SmartStudy',
      'app_tagline': 'Cari tutor, belajar lebih pintar',

      // Login
      'welcome_back': 'Selamat Kembali',
      'login_subtitle': 'Log masuk untuk teruskan belajar',
      'email': 'E-mel',
      'password': 'Kata Laluan',
      'login': 'Log Masuk',
      'no_account': 'Belum ada akaun? Daftar',
      'login_failed': 'Log masuk gagal',

      // Register
      'create_account': 'Cipta Akaun Baharu',
      'register_subtitle': 'Sertai SmartStudy hari ini',
      'full_name': 'Nama Penuh',
      'phone': 'No. Telefon',
      'register': 'Daftar',
      'register_failed': 'Pendaftaran gagal',
      'register_title': 'Daftar Akaun',

      // Home
      'welcome_greeting': 'Selamat datang! 👋',
      'welcome_desc': 'Cari tutor pilihan anda dan mula belajar dengan lebih yakin.',
      'start_here': 'Mula di sini',
      'find_tutor': 'Cari Tutor',
      'find_tutor_desc': 'Pilih subjek dan tapis tutor ikut lokasi',
      'logout': 'Log keluar',

      // Subject
      'choose_subject': 'Pilih Subjek',
      'no_subjects': 'Tiada subjek dalam pangkalan data.',
      'error_loading': 'Ralat',

      // Tutor List
      'mode': 'Mod',
      'district': 'Daerah',
      'online': 'Online',
      'face_to_face': 'Bersemuka',
      'no_tutors': 'Tiada tutor dijumpai.',
      'rating': 'Penilaian',

      // Language
      'language': 'Bahasa',
      'english': 'English',
      'malay': 'Bahasa Melayu',
    },
  };

  static String t(String code, String key) {
    return _data[code]?[key] ?? _data['en']?[key] ?? key;
  }
}