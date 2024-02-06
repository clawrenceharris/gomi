import 'package:flutter/material.dart';

class QuitButton extends StatelessWidget {
  const QuitButton({super.key});
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () =>
            Navigator.of(context).popUntil((route) => route.isFirst),
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
            const Text(
              'quit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
  }
}
