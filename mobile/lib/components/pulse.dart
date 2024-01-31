import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../pages/camera_page.dart';

class MyAnimatedIcon extends StatefulWidget {
  const MyAnimatedIcon({super.key});

  @override
  _MyAnimatedIconState createState() => _MyAnimatedIconState();
}

class _MyAnimatedIconState extends State<MyAnimatedIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        FadeTransition(
          opacity: _controller,
          child: ScaleTransition(
            scale: _animation,
            child: Container(
              width: 50 * 5,
              height: 50 * 5,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.purple.shade300),
            ),
          ),
        ),
        ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(), 
        backgroundColor: Colors.purple,
        padding: const EdgeInsets.all(100),
      ),
      onPressed: () async {
        List<CameraDescription> cameras = await availableCameras();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CameraPage(cameras: cameras)),
              );
      },
      child: const Text(
        'Démarrer l\'entrainement',
        style: TextStyle(color: Colors.white),
      ),
    ),
      ],
    );
  }
}
