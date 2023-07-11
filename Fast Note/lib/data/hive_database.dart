import 'package:hive/hive.dart';

import '../models/note.dart';

class HiveDatabase {
  final _myBox = Hive.box('note_database');
  //Carregamento...
  List<Note> loadNotes() {
    List<Note> savedNotesFormatted = [];

    //"Se houver retorne 1, caso contrario retorne 0"
    if (_myBox.get("ALL_NOTES") != null) {
      List<dynamic> savedNotes = _myBox.get("ALL_NOTES");
      for (int i = 0; i < savedNotes.length; i++) {
        //create
        Note individualNote = Note(
            id: savedNotes[i][0],
            name: savedNotes[i][1],
            text: savedNotes[i][2]);

        //add to list
        savedNotesFormatted.add(individualNote);
      }
    } else {
      // default da lista
      savedNotesFormatted.add(Note(id: 0, text: 'Bem-vindo(a)'));
    }

    return savedNotesFormatted;
  }

  //save notes
  void savedNotes(List<Note> allNotes) {
    List<List<dynamic>> allNotesFormatted = [
      /*

      [


      [0 , "First Note"],
      [1 , "Second Note"],
      ..



      ]
       */
    ];

    for (var note in allNotes) {
      int id = note.id;
      String text = note.text;
      allNotesFormatted.add([id, text]);
    }

    //then store into hive
    _myBox.put("ALL_NOTES", allNotesFormatted);
  }
}
