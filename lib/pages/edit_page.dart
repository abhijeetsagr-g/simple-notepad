import 'package:flutter/material.dart';
import 'package:notepad/classes/note.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key, required this.note});

  final Note note;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool readOnly = true;
  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController(
      text: widget.note.title,
    );
    final TextEditingController bodyController = TextEditingController(
      text: widget.note.body,
    );
    final notelist = Provider.of<NoteList>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (!readOnly &&
                    (titleController.text.isNotEmpty ||
                        bodyController.text.isNotEmpty)) {
                  notelist.editNote(
                    Note(
                      widget.note.id,
                      titleController.text,
                      bodyController.text,
                    ),
                  );

                  widget.note.title = titleController.text;
                  widget.note.body = bodyController.text;
                }

                readOnly = !readOnly;
              });
            },
            icon: readOnly ? Icon(Icons.edit) : Icon(Icons.save),
          ),
          IconButton(
            onPressed: () {
              notelist.deleteNote(widget.note);
              Navigator.pop(context);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, left: 15),
            child: TextField(
              readOnly: readOnly,
              style: TextStyle(fontSize: 24),
              controller: titleController,
              maxLength: 50,
              maxLines: 1,
              minLines: 1,
              decoration: InputDecoration(
                counterText: "",
                border: InputBorder.none,
                hintText: "Title",
                // hintStyle: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: TextField(
              readOnly: readOnly,
              controller: bodyController,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Note",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
