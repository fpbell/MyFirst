import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'models/notes.dart';

class EditScreen extends StatefulWidget {
  final String title;
  final bool isView, isEdit, isNew;
  Note? selectedNote;
  EditScreen({
    Key? key,
    required this.title,
    this.selectedNote,
    required this.isView,
    required this.isEdit,
    required this.isNew,
  }) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? noteTitle = "", noteContent = "";

  @override
  void initState() {
    setState(() {
      noteTitle = widget.selectedNote != null
          ? widget.selectedNote!.title.toString()
          : "";

      noteContent = widget.selectedNote != null
          ? widget.selectedNote!.content.toString()
          : "";

      _titleController.text = noteTitle.toString();
      _descriptionController.text = noteContent.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: Text(widget.title),
        actions: [
          if (widget.isView == false)
            IconButton(
                icon: const Icon(
                  Icons.check_circle,
                  size: 30,
                ),
                onPressed: () {}),
          IconButton(
              icon: const Icon(
                Icons.cancel_sharp,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              readOnly: widget.isView,
              controller: _titleController,
              initialValue: null,
              enabled: true,
              decoration: const InputDecoration(
                hintText: 'Type the title here',
              ),
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: TextFormField(
                  readOnly: widget.isView,
                  controller: _descriptionController,
                  enabled: true,
                  initialValue: null,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    hintText: 'Type the description',
                  ),
                  onChanged: (value) {}),
            ),
          ],
        ),
      ),
    );
  }
}
