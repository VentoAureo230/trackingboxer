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
        CREATE TABLE training (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          date DATE,
          longitude INT,
          latitude INT,
          media TEXT
        );

        CREATE TABLE user (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          firstName TEXT,
          lastName TEXT,
          imageUrl TEXT
        );
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
      title: 'Flutter Camera Demo',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}