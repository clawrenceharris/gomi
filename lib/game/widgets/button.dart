import 'package:flutter/material.dart';

class ButtonModel {}

class Button extends StatelessWidget {
  const Button({required this.text, required this.onPressed, super.key});
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background image
            Image.asset(
              'assets/images/hud/menu_button.png',
              width: 200,
              height: 60,
              fit: BoxFit.contain,
            ),

            // Text widget on top of the image
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
  }
}
