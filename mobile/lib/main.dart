// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trackingboxer/pages/auth/login_page.dart';
import 'database/database_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Database>(
      future: DatabaseHelper().database,
      builder: (BuildContext context, AsyncSnapshot<Database> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print('Db loaded');
          return const MaterialApp(
            title: 'Flutter Camera Demo',
            debugShowCheckedModeBanner: false,
            home: LoginPage(),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}