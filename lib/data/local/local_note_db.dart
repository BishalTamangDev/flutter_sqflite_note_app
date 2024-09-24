import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NoteDb {
  // private constructor
  NoteDb._();

  Database? db;

  static NoteDb getInstance() => NoteDb._();

// open database
  Future<Database> openDb() async {
    Directory appDir = await getApplicationDocumentsDirectory();

    String dbPath = join(appDir.path, "note.db");

    return await openDatabase(dbPath, onCreate: (db, version) {
      db.execute(
          "create table note (id integer primary key autoincrement, title text, description text, date_time Text)");
    }, version: 1);
  }

  // get database
  Future<Database> getDb() async {
    db ??= await openDb();
    return db!;
  }

// get all notes
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    Database tempDb = await getDb();
    List<Map<String, dynamic>> data = await tempDb.query('note');
    return data;
  }

// insert
  Future<bool> addNote(
      String title, String description, String dateTime) async {
    Database tempDb = await getDb();
    int rowAffected = await tempDb.insert('note', {
      'title': title,
      'description': description,
      'date_time': dateTime,
    });
    return rowAffected > 0;
  }

// update
  Future<bool> updateNote(
      int id, String title, String description, String dateTime) async {
    Database tempDb = await getDb();
    int rowAffected = await tempDb.update(
        'note',
        {
          'title': title,
          'description': description,
          'date_time': dateTime,
        },
        where: "id = $id");
    return rowAffected > 0;
  }

// delete
  Future<bool> deleteNote(int id) async {
    Database tempDb = await getDb();
    int rowAffected = await tempDb.delete('note', where: "id = $id");
    return rowAffected > 0;
  }
}
