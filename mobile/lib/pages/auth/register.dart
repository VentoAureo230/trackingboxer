import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trackingboxer/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../database/database_helper.dart';
import '../../models/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
        child: Column(
          children: [
            const Center(
              child: Text(
                'Register page',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
              ),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )),
            ),
            ElevatedButton(
              onPressed: () async {
                String email = emailController.text;
                String password = passwordController.text;

                if (email.isNotEmpty && password.isNotEmpty) {
                  bool saveResult = await _saveToDataBase(email, password);
                  print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!saveResult: $saveResult');
                  if (saveResult) {
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error creating user')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Email and password cannot be empty')),
                  );
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> _saveToDataBase(String email, String password) async {
  final database = await DatabaseHelper().database;

  final user = User(
      firstName: 'first_name',
      lastName: 'last_name',
      profileUrl: 'profileUrl',
      email: email,
      password: password);
  
  try {
    int id = await database.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', id);
    print(prefs.getInt('userId'));
    return true;
  } catch (e) {
    print('Error creating user: $e');
    return false;
  }
  
}
