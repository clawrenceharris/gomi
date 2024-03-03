import 'package:flutter/material.dart';
import 'package:gomi/game/widgets/gradient_text.dart';

class AnimatedTextMovement extends StatefulWidget {
  const AnimatedTextMovement({required this.text, super.key});
  final String text;
  @override
  State<AnimatedTextMovement> createState() => _AnimatedTextMovementState();
}

class _AnimatedTextMovementState extends State<AnimatedTextMovement>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  _AnimatedTextMovementState();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Adjust the duration as needed
    );

    _animation = Tween<double>(
      begin: -40,
      end: -20, // Adjust the maximum vertical movement
    ).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
            offset: Offset(0, _animation.value),
            child: GradientTextWidget(
                fontSize: 22,
                gradientColors: const [Colors.blue, Colors.purple],
                text: widget.text));
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
