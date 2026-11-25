import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/subject.dart';
import '../models/tutor.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Future<List<Subject>> getSubjects() async {
    final snap = await _db.collection('subjects').get();
    return snap.docs.map((d) => Subject.fromDoc(d)).toList();
  }

  Future<List<Tutor>> getTutors({
  required String subjectId,
  String? mode,
  String? district,
}) async {
  Query query = _db
      .collection('tutors')
      .where('subjects', arrayContains: subjectId);

  if (mode != null && mode.isNotEmpty) {
     query = query.where('modes', arrayContains: mode);
   }
   if (district != null && district.isNotEmpty) {
     query = query.where('district', isEqualTo: district);
   }

  final snap = await query.get();
  print('DEBUG: Dapat ${snap.docs.length} tutor untuk subjek $subjectId');
  return snap.docs.map((d) => Tutor.fromDoc(d)).toList();
}
}