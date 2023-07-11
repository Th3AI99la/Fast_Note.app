import 'package:flutter/material.dart';
import 'package:notes/data/hive_database.dart';
import 'note.dart';

class NoteData extends ChangeNotifier {
  //Database
  final db = HiveDatabase();

  //Lista geral
  List<Note> allNotes = [];

  //Inicializador
  void initializeNotes() {
    allNotes = db.loadNotes();
  }

  //Get notes
  List<Note> getAllNotes() {
    return allNotes;
  }

  //Add a new note
  void addNewNote(Note note) {
    allNotes.add(note);
    notifyListeners();
  }

  //Update note
  void upgradeNote(Note note, String text) {
    for (int i = 0; i < allNotes.length; i++) {
      if (allNotes[i].id == note.id) {
        allNotes[i].text = text;
      }
    }
    notifyListeners();
  }

  void deleteNote(Note note) {
    allNotes.remove(note);
    notifyListeners();
  }
}
