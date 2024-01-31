import 'package:flutter/material.dart';
import 'package:trackingboxer/pages/auth/register.dart';

import 'login_page.dart';

class MainPageAuth extends StatelessWidget {
  const MainPageAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF4654A3),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                    'Tracking Boxer',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'SF Pro Display'),
                  ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(327, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                icon: const Icon(Icons.login_rounded),
                label: const Text('Login'),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterPage()));
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(327, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                icon: const Icon(Icons.app_registration_rounded),
                label: const Text('Register'),
              ),
              const SizedBox(height: 50),
            ],
          ),
        )
      ),
    );
  }
}