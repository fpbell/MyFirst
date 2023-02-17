import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/notes.dart';

class NoteList {
  static Future<List<Note>> callItemAPI() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      User? uid = FirebaseAuth.instance.currentUser;

      // DocumentSnapshot documentSnapshot =
      //   await firestore.collection('notes').doc(uid!.uid).get();

      //notesList = documentSnapshot.data()['docArray'];

      final docNote = firestore.collection('notes').doc(uid!.uid);
      DocumentSnapshot doc = await docNote.get();
      final data = doc.data() as Map<String, dynamic>;

      final itemList =
          List<Note>.from(data['docArray'].map((e) => Note.fromJson(e)));

      return itemList;
    } catch (e) {
      List<Note> itemNull = [];
      return itemNull;
    }
  }
}
