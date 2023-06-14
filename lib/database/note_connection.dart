import 'dart:io';
import 'package:note_app/global/constant/data_fields.dart';
import 'package:note_app/global/style/style_widget.dart';
import 'package:note_app/model/category_model.dart';
import 'package:note_app/model/note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NoteDB {
  Future<Database> initializeDatabase() async {
    final Directory tempDir = await getTemporaryDirectory();
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'noteDB.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE $noteTable($note_id INTEGER PRIMARY KEY, $note_title TEXT,$note_description TEXT, $note_color TEXT,$categoryName TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertNote(NoteModel note) async {
    var db = await initializeDatabase();
    await db.insert(noteTable, note.toMap());
    print('hi');
  }

  Future<List<NoteModel>> getNote() async {
    var db = await initializeDatabase();
    List<Map<String, dynamic>> result = await db.query(noteTable);
    return result.map((e) => NoteModel.fromMap(e)).toList();
  }

  Future<void> deleteNote(int noteId) async {
    var db = await initializeDatabase();
    await db.delete(noteTable, where: '$note_id=?', whereArgs: [noteId]);
  }

  Future<void> updateNote(NoteModel note) async {
    var db = await initializeDatabase();
    await db.update(noteTable, note.toMap(),
        where: '$note_id=?', whereArgs: [note.id]);
  }
}
