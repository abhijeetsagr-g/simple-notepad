import 'package:flutter/material.dart';
import 'package:notepad/classes/database_helper.dart';
import 'package:notepad/classes/note.dart';
import 'package:notepad/pages/new_page.dart';
import 'package:notepad/widgets/note_card.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => NoteList(),
      child: MaterialApp(
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        ),
        debugShowCheckedModeBanner: false,
        home: Main(),
      ),
    ),
  );
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    final noteList = Provider.of<NoteList>(context, listen: true);
    noteList.reloadList();

    return Scaffold(
      // App Bar
      appBar: AppBar(
        centerTitle: true,
        title: Text("Simple Notepad"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(color: Colors.grey[300], height: 1.0),
        ),
      ),

      // main
      body: ListView.builder(
        itemCount: noteList.notesList.length,
        itemBuilder: (context, index) {
          final note = noteList.notesList[index];

          return Column(
            children: [
              NoteCard(note: note),
              SizedBox(height: 5),
            ],
          );
        },
      ),

      // fab
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contex) {
                return NewPage();
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
