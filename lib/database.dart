import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class StudentManagerDb {
  static StudentManagerDb? _instance;

  static Database? _db;

  StudentManagerDb._private();

  factory StudentManagerDb() {
    _instance ??= StudentManagerDb._private();
    return _instance!;
  }

  Future<Database?> get database async {
    if (_db != null) return _db;
    _db = await _initDatabase();
    return _db;
  }

  Future<Database> _initDatabase() async {
    Directory docDirectory = await getApplicationDocumentsDirectory();
    String path = join(docDirectory.path, "student_manager.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE marks (
      id      INTEGER      PRIMARY KEY AUTOINCREMENT,
      subject VARCHAR (64) NOT NULL,
      mark    INTEGER      NOT NULL,
      exam    VARCHAR (64) NOT NULL,
      date    VARCHAR (64) NOT NULL,
      notes   TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE tasks (
      id        INTEGER      PRIMARY KEY AUTOINCREMENT,
      subject   VARCHAR (64) NOT NULL,
      task      TEXT         NOT NULL,
      date      VARCHAR (64) NOT NULL,
      taskState VARCHAR(64)  NOT NULL
      );
    ''');
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    switch (newVersion) {
      default:
        break;
    }
  }

  void close() async {
    await _db?.close();
  }
}
