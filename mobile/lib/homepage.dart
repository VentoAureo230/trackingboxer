import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'camera_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: SafeArea(
        child: Center(
            child: ElevatedButton(
          onPressed: () async {
            List<CameraDescription> cameras = await availableCameras();
            if (cameras.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CameraPage(cameras: cameras)),
              );
            } else {
              print("No cameras available.");
            }
          },
          child: const Text("Take a Picture"),
        )),
      ),
    );
  }
}
