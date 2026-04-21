import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addOrUpdateNote(Map<String, dynamic> note) async {
    await _firestore.collection('notes').doc(note['id']).set(note);
  }

  Future<List<Map<String, dynamic>>> fetchNotes() async {
    final snapshot = await _firestore.collection('notes').get();
    return snapshot.docs.map((e) => e.data()).toList();
  }
}