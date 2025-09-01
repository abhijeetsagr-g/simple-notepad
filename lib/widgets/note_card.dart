import 'package:flutter/material.dart';
import 'package:notepad/classes/note.dart';
import 'package:notepad/pages/edit_page.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note});
  final Note note;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (contex) {
              return EditPage(note: note);
            },
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (note.title.isNotEmpty)
                Text(
                  note.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),

              SizedBox(height: 10),
              if (note.body.isNotEmpty)
                Text(
                  note.body.length > 50
                      ? '${note.body.substring(0, 50)}.....'
                      : note.body,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
