import 'package:flutter/material.dart';

class AnimatedIcon extends StatefulWidget {
  const AnimatedIcon({super.key});

  @override
  _AnimatedIconState createState() => _AnimatedIconState();
}

class _AnimatedIconState extends State<AnimatedIcon> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  )..repeat();

  late final Animation<double> _scaleAnimation = Tween<double>(begin: 0.6, end: 1.2).animate(_controller);

  late final Animation<double> _fadeAnimation = Tween<double>(begin: 1, end: 0.2).animate(_controller);

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
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: 50 * 1.5,
              height: 50 * 1.5,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green.shade300),
            ),
          ),
        ),
        Icon(
          Icons.play_circle,
          size: 50,
          color: Colors.green,
        ),
      ],
    );
  }
}
