import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'trackingboxer_database.db');
    return await openDatabase(
      path, 
      version: 1, 
      onCreate: _onCreate
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE user (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name TEXT,
          last_name TEXT,
          profileUrl TEXT,
          email TEXT,
          password TEXT
        )
      ''');

    await db.execute('''
        CREATE TABLE photos (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          url TEXT NOT NULL,
          longitude TEXT NOT NULL,
          latitude TEXT NOT NULL,
          publication_date TEXT NOT NULL
        )
      ''');

    await db.execute('''
        CREATE TABLE trainings (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          timer INTEGER NOT NULL,
          jump_count INTEGER NOT NULL,
          photo_id INTEGER NOT NULL,
          FOREIGN KEY (photo_id) REFERENCES photos(id)
        )
      ''');
  }
}