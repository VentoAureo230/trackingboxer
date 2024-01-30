// ignore_for_file: unused_import, depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../database/database_helper.dart';
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

  void myAlert(BuildContext context, Function(String) onImageSelected) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: const Text('Please choose media to select'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    String? imageUrl = await getImage(ImageSource.gallery);
                    if (imageUrl != null) {
                      onImageSelected(imageUrl);
                    } else {
                      onImageSelected(imageUrl = 'Cancel');
                    }
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.image),
                      Text('From Gallery'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<User?> _getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? userId = prefs.getInt('userId');

  if (userId != null) {
    final database = await DatabaseHelper().database;
    List<Map<String, dynamic>> maps = await database.query(
      'user',
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
  }

  return null;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          FutureBuilder<User?>(
            future: _getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                User user = snapshot.data!;
                return Column(
                  children: [
                    Text('Nom: ${user.lastName}'),
                    Text('Prénom: ${user.firstName}'),
                  ],
                );
              } else {
                return Text('Aucun utilisateur connecté');
              }
            },
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Column(children: [
                
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          myAlert(context, (imageUrl) {
                            _saveToDataBase(
                                firstNameController, lastNameController, imageUrl);
                          });
                        },
                        child: const Text('Upload avatar & save')),
                  ],
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

Future _saveToDataBase(
    firstNameController, lastNameController, imageUrl) async {

  final database = await DatabaseHelper().database;

  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? userId = prefs.getInt('userId');

  final String firstName = firstNameController.text;
  final String lastName = lastNameController.text;
  final String imageUrl = '';
  
  if (userId != null) {
    final user = User(
      firstName: firstName,
      lastName: lastName,
      profileUrl: imageUrl,
    );

    await database.update(
      'user',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [userId],
    );
  } else {
    print('Error insert user');
  }
  await database.close();
}
