import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gomi/main_menu/main_menu_screen.dart';

class AnimatedTextMovement extends StatefulWidget {
  const AnimatedTextMovement({required this.text, super.key});
  final String text;
  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _AnimatedTextMovementState createState() =>
      // ignore: no_logic_in_create_state
      _AnimatedTextMovementState(text: text);
}

class _AnimatedTextMovementState extends State<AnimatedTextMovement>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  _AnimatedTextMovementState({required this.text});
  final String text;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Adjust the duration as needed
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
                text: text));
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
