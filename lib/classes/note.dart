import 'package:flutter/material.dart';
import 'package:notepad/classes/database_helper.dart';

class Note {
  late int? id;
  late String title;
  late String body;

  Note(this.id, this.title, this.body);

  Map<String, dynamic> toMap() {
    return {"id": id, "title": title, "body": body};
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(map["id"], map["title"], map["body"]);
  }
}

class NoteList with ChangeNotifier {
  List<Note> _list = [];
  final db = DatabaseHelper.instance;

  List<Note> get notesList => _list;

  Future<void> reloadList() async {
    _list = await db.readData();
    notifyListeners();
  }

  void addNote(Note note) {
    db.insertData(note);
    reloadList();
  }

  void deleteNote(Note note) {
    db.deleteData(note.id);
    reloadList();
  }

  void editNote(Note newNote) {
    db.updateData(newNote);
    reloadList();
  }
}
