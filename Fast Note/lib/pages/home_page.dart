import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../models/note_data.dart';
import 'editing_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).initializeNotes();
  }

  void createNewNote() {
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    Note newNote = Note(id: id, text: '');

    goNotePage(newNote, true);
  }

  void goNotePage(Note note, bool isNewNote) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditingNotePage(
          note: note,
          isNewNote: isNewNote,
        ),
      ),
    );
  }

  //delete note
  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Color.fromARGB(225, 146, 145, 145),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewNote,
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          child: const Icon(
            Icons.add,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25.0, top: 75),
              child: Text(
                'Notas',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),

            //list of notes
            value.getAllNotes().length == 0
                ? Padding(
                    padding: const EdgeInsets.only(top: 300.0),
                    child: Center(
                      child: Text(
                        'Nenhuma Nota',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 5.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                            color: Color.fromARGB(255, 181, 181, 181),
                            thickness: 3.0,
                          ),
                          itemCount: value.getAllNotes().length,
                          itemBuilder: (context, index) {
                            Note note = value.getAllNotes()[index];
                            return Dismissible(
                              key: Key(note.id.toString()),
                              onDismissed: (_) => deleteNote(note),
                              background: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                child: ListTile(
                                  tileColor: Color.fromARGB(160, 144, 144, 125),
                                  title: Text(
                                    note.text,
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255)),
                                  ),
                                  onTap: () => goNotePage(note, false),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
