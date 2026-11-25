import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  String _languageCode = 'en'; // default English

  String get languageCode => _languageCode;

  bool get isMalay => _languageCode == 'ms';
  bool get isEnglish => _languageCode == 'en';

  void setLanguage(String code) {
    if (_languageCode == code) return;
    _languageCode = code;
    notifyListeners();
  }

  void toggle() {
    _languageCode = _languageCode == 'en' ? 'ms' : 'en';
    notifyListeners();
  }
}