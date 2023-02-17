import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map_exam/models/notes.dart';

import 'edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NotesModel> notes = [];
  bool isShow = true;

  @override
  void initState() {
    _updateDoc();
    super.initState();
  }

  Future<void> _updateDoc() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    User? uid = FirebaseAuth.instance.currentUser;

    // DocumentSnapshot documentSnapshot =
    //   await firestore.collection('notes').doc(uid!.uid).get();

    //notesList = documentSnapshot.data()['docArray'];

    final docNote = firestore.collection('notes').doc(uid!.uid);
    DocumentSnapshot doc = await docNote.get();
    final data = doc.data() as Map<String, dynamic>;

    final itemList = List<NotesModel>.from(
        data['docArray'].map((e) => NotesModel.fromJson(e)));

    setState(() {
      if (mounted) {
        notes = itemList;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade200,
            child: Text(
              notes.length.toString(),
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: notes.length,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.blueGrey,
        ),
        itemBuilder: (context, index) => ListTile(
          trailing: SizedBox(
            width: 110.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.blue,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          title: Text(notes[index].title.toString()),
          subtitle: Visibility(
              visible: isShow, child: Text(notes[index].content.toString())),
          onTap: () {},
          onLongPress: () {},
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              heroTag: "btn1",
              child: Icon(isShow == true ? Icons.unfold_less : Icons.menu),
              tooltip: 'Show less. Hide notes content',
              onPressed: () {
                setState(() {
                  bool isClick = !isShow;
                  isShow = isClick;
                });
              }),

          /* Notes: for the "Show More" icon use: Icons.menu */

          FloatingActionButton(
            heroTag: "btn2",
            child: const Icon(Icons.add),
            tooltip: 'Add a new note',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const EditScreen()));
            },
          ),
        ],
      ),
    );
  }
}
