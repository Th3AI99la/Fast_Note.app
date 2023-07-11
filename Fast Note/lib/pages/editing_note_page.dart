import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../models/note_data.dart';

class EditingNotePage extends StatefulWidget {
  final Note note;
  final bool isNewNote;

  EditingNotePage({
    Key? key,
    required this.note,
    required this.isNewNote,
  }) : super(key: key);

  @override
  State<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends State<EditingNotePage> {
  late QuillController _controller;

  @override
  void initState() {
    super.initState();
    _controller = QuillController(
      document: Document()..insert(0, widget.note.text),
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  void addNewNote() {
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    String text = _controller.document.toPlainText();
    Provider.of<NoteData>(context, listen: false).addNewNote(
      Note(id: id, name: "Nova Nota", text: text),
    );
  }

  void updateNote() {
    String text = _controller.document.toPlainText();
    Provider.of<NoteData>(context, listen: false).upgradeNote(widget.note, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(225, 146, 145, 145),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (widget.isNewNote && !_controller.document.isEmpty()) {
              addNewNote();
            } else {
              updateNote();
            }
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Divider(
            color: Color.fromARGB(234, 255, 255, 255),
            height: 3,
            thickness: 50,
          ),
          Align(
            alignment: Alignment.center,
            child: QuillToolbar.basic(
              controller: _controller,
              showAlignmentButtons: true,
              showBackgroundColorButton: false,
              showCenterAlignment: true,
              showColorButton: false,
              showCodeBlock: true,
              showDirection: false,
              showFontFamily: false,
              showDividers: false,
              showIndent: false,
              showHeaderStyle: true,
              showLink: false,
              showSearchButton: true,
              showInlineCode: false,
              showQuote: true,
              showListNumbers: true,
              showListBullets: true,
              showClearFormat: false,
              showBoldButton: false,
              showFontSize: false,
              showItalicButton: false,
              showUnderLineButton: false,
              showStrikeThrough: false,
              showListCheck: false,
              showSubscript: false,
              showSuperscript: false,
            ),
          ),
          Divider(
            color: Color.fromARGB(92, 132, 132, 132),
            height: 1,
            thickness: 1,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(25),
              child: QuillEditor.basic(
                controller: _controller,
                readOnly: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
