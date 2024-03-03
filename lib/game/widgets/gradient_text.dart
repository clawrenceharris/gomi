import 'package:flutter/material.dart';

class GradientTextWidget extends StatelessWidget {
  final String text;
  final List<Color> gradientColors;
  final double fontSize;

  const GradientTextWidget(
      {required this.text,
      required this.gradientColors,
      required this.fontSize,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: 'Pixel',
          color: Colors.white, // Text color on the gradient text
        ),
      ),
    );
  }
}
