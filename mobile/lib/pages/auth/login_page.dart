import 'package:flutter/material.dart';

import '../../database/database_helper.dart';
import '../home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

 
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                'Login page',
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
                  bool saveResult = await _login(email, password);
                  print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!saveResult: $saveResult');
                  if (saveResult) {
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Utilisateur non trouvé')),
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

Future<bool> _login(String email, String password) async {
  final database = await DatabaseHelper().database;

  final List<Map<String, dynamic>> users = await database.query('user',
      where: 'email = ? AND password = ?', whereArgs: [email, password]);

  if (users.isNotEmpty) {
    return true;
  } else {
    const SnackBar(content: Text('Utilisateur non trouvé'));
    return false;
  }
}