import 'package:flutter/material.dart';

class ResumeButton extends StatelessWidget {
  const ResumeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent)),
        onPressed: () {
          Navigator.of(context).pop();
        },
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
              'resume',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 200, // Match the width of the image
                height: 60, // Match the height of the image
                color: Colors.transparent,
              ),
            ),
          ],
        ));
  }
}
