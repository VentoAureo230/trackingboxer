import 'package:flutter/material.dart';
import 'package:trackingboxer/components/pulse.dart';
import 'package:trackingboxer/pages/profile/profile_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4654A3),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
            }, 
            icon: const Icon(Icons.person, color: Colors.white))
        ],
      ),
      body: const SafeArea(
        child: Center(
          child: MyAnimatedIcon(),
        ),
      ),
      backgroundColor: Color(0xFF4654A3),
    );
  }
}
