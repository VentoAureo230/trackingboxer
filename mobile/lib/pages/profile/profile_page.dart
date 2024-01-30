import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


import '../../models/user.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  XFile? image;

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  void myAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Sélectionnez une photo'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
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
              const SizedBox(height: 15,),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  hintText: 'Nom'
                ),
              ),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: () {
                    myAlert(context);
                    print((context));
                  }, child: const Text('Upload avatar')),
                            
                  ElevatedButton(onPressed: () async {
                    await _saveToDataBase(firstNameController, lastNameController);
                  }, child: const Text('Save')),
                ],
              )
          ]),
        ),
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