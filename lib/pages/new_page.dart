import 'package:flutter/material.dart';
import 'package:notepad/classes/note.dart';
import 'package:provider/provider.dart';

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  late dynamic _noteList;

  @override
  void dispose() {
    super.dispose();

    titleController.dispose();
    bodyController.dispose();
  }

  void _onSave() {
    if (titleController.text.isNotEmpty || bodyController.text.isNotEmpty) {
      _noteList.addNote(
        Note(
          _noteList.notesList.length + 1,
          titleController.text,
          bodyController.text,
        ),
      );
      // Show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Note saved successfully ✅"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _noteList = Provider.of<NoteList>(context, listen: false);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        _onSave();
      },

      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                _onSave;
                Navigator.pop(context);
              },
              icon: Icon(Icons.save),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, left: 15),
              child: TextField(
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
      ),
    );
  }
}
