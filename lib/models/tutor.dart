import 'package:cloud_firestore/cloud_firestore.dart';

class Tutor {
  final String id;
  final String name;
  final String email;
  final String phone;
  final List<String> subjects;
  final List<String> modes;
  final String district;
  final String bio;
  final double rating;
  final int totalReviews;

  Tutor({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.subjects,
    required this.modes,
    required this.district,
    required this.bio,
    required this.rating,
    required this.totalReviews,
  });

  factory Tutor.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Tutor(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      subjects: List<String>.from(data['subjects'] ?? []),
      modes: List<String>.from(data['modes'] ?? []),
      district: data['district'] ?? '',
      bio: data['bio'] ?? '',
      rating: (data['rating'] ?? 0).toDouble(),
      totalReviews: data['totalReviews'] ?? 0,
    );
  }
}