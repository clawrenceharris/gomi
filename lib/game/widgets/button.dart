import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gomi/audio/audio_controller.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:provider/provider.dart';

class ButtonModel {}

class Button extends StatelessWidget {
  const Button({required this.text, required this.onPressed, super.key});
  final String text;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    final audioController = context.watch<AudioController>();

    return TextButton(
        onPressed: () {
          onPressed();
          audioController.playSfx(SfxType.buttonTap);
        },
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background image
            Image.asset(
              'assets/images/hud/menu_button.png',
              width: Platform.isMacOS || Platform.isWindows || Platform.isLinux
                  ? 200
                  : 150,
              height: Platform.isMacOS || Platform.isWindows || Platform.isLinux
                  ? 60
                  : 50,
              fit: BoxFit.contain,
            ),

            // Text widget on top of the image
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Pixel',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
  }
}
