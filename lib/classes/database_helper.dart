import 'package:notepad/classes/note.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY,
            title TEXT NOT NULL,
            body TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // Create
  Future<int> insertData(Note note) async {
    final db = await instance.database;
    return await db.insert('notes', note.toMap());
  }

  // Read
  Future<List<Note>> readData() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> list = await db.query("notes");

    return List.generate(list.length, (i) {
      return Note.fromMap(list[i]);
    });
  }

  // Update
  Future<int> updateData(Note note) async {
    final db = await instance.database;
    return await db.update(
      'notes',
      note.toMap(),
      where: "id = ?",
      whereArgs: [note.id],
    );
  }

  // Delete
  Future<int> deleteData(int? index) async {
    final db = await instance.database;
    return await db.delete("notes", where: "id = ?", whereArgs: [index]);
  }
}
