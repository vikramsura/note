import 'dart:io';

import 'package:note/model/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  DatabaseHelper._createInstance();

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colDate = 'date';
  String colItem = 'item';

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database?> get database async {
    _database ??= await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationCacheDirectory();
    String path = "${directory.path}notes.db";
    var noteDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return noteDatabase;
  }

  Future<void> _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDescription TEXT, $colItem INTEGER, $colDate TEXT)');
  }

  Future<List<Map<String, Object?>>?> getNoteMapList() async {
    Database? db = await database;
    var result =
        await db?.rawQuery('SELECT * FROM $noteTable order by $colItem ASC');
    var results = await db?.query(noteTable, orderBy: '$colItem ASC');
    print("rrr:$result");
    return result;
  }

  Future<int?> insertNote(NoteData note) async {
    Database? db = await database;

    var result = await db?.insert(noteTable, note.toMap());
    return result;
  }

  Future<int?> updateNote(NoteData note) async {
    var db = await database;
    var result = await db?.update(noteTable, note.toMap(),
        where: '$colId=?', whereArgs: [note.id]);
    return result;
  }

  Future<int?> deleteNote(int id) async {
    var db = await database;
    int? result =
        await db?.rawDelete('DELETE FROM $noteTable WHERE $colId=$id');
    return result;
  }

  Future<int?> getCount() async {
    Database? db = await this.database;
    List<Map<String, Object?>>? x =
        await db?.rawQuery('SELECT COUNT (*) from $noteTable');
    int? result = Sqflite.firstIntValue(x!);
    return result;
  }

  Future<List<NoteData>> getNoteList() async {
    var noteMapList = await getNoteMapList(); // Corrected method call
    List<NoteData> noteList = [];
    if (noteMapList != null) {
      int count = noteMapList.length;
      for (int i = 0; i < count; i++) {
        noteList.add(
            NoteData.formMapObject(noteMapList[i] as Map<String, dynamic>));
      }
    }
    return noteList;
  }
}
