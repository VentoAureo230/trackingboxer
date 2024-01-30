// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String url = await getDatabasesPath();
  print(url);
  final database = openDatabase(
    join(await getDatabasesPath(), 'user_database.db'),
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE user (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          firstName TEXT,
          lastName TEXT,
          imageUrl TEXT
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
    },
    version: 1,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Training Tracker',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
