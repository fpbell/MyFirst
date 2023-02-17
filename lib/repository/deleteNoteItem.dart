import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/notes.dart';

class DeleteNoteItem {
  static Future<List<Note>> callItemAPI(List<Note> notes, int index) async {
    try {
      notes.removeAt(index);

      List<Map<String, dynamic>> doc1 =
          List<Map<String, dynamic>>.from(notes.map((e) => e.toJson()));

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      User? uid = FirebaseAuth.instance.currentUser;

      firestore
          .collection('notes')
          .doc(uid!.uid)
          .update({
            'docArray': doc1,
          })
          .then((value) => print('updated'))
          .catchError((error) => print(error.toString()));

      return notes;
    } catch (e) {
      List<Note> noteNull = [];
      return noteNull;
    }
  }
}
