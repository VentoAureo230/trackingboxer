import 'package:flutter/material.dart';

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
              // save data to db
            }, child: const Text('Save'))
        ]),
      ),
    );
  }
}