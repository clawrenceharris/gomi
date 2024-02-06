import 'package:flutter/material.dart';

class ButtonModel {
  final void Function() onPressed;
  final String text;
  ButtonModel({required this.onPressed, required this.text});
}

class Button extends StatelessWidget {
  const Button({required this.buttonModel, super.key});
  final ButtonModel buttonModel;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: buttonModel.onPressed,
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
              buttonModel.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
  }
}
