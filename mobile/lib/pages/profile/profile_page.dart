import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../models/user.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(),
            Text('Nom'),
            Text('Prénom'),


            TextField(
              controller: firstNameController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Prénom'
              ),
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(
                hintText: 'Nom'
              ),
            ),
            ElevatedButton(onPressed: () {
              
            }, child: Text('Upload avatar')),

            ElevatedButton(onPressed: () async {
              await _saveToDataBase(firstNameController, lastNameController);
            }, child: const Text('Save'))
        ]),
      ),
    );
  }
}

Future _saveToDataBase(firstNameController, lastNameController) async {
  final database = await openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      version: 1,
    );

  final String firstName = firstNameController.text;
  final String lastName = lastNameController.text;
  final String imageUrl = ''; 
  
  final user = User(0, firstName, lastName, imageUrl);

  await database.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  await database.close();
}