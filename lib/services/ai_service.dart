import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  // Tampal API KEY anda di sini
  static const String _apiKey = '';
  
  Future<String> getAIResponse(String userMessage) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$_apiKey',
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text": "You are SmartStudy AI, a helpful tutor for Malaysian Form 4 and Form 5 students. Answer questions simply and clearly. Question: $userMessage"
              }
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates'][0]['content']['parts'][0]['text'];
    } else {
      throw Exception('Failed to get AI response: ${response.statusCode}');
    }
  }
}