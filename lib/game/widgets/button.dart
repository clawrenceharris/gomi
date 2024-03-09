import 'package:flutter/material.dart';
import 'package:gomi/audio/audio_controller.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/game/utils.dart';
import 'package:provider/provider.dart';

class Button extends StatelessWidget {
  const Button({this.text, required this.onPressed, this.child, super.key});
  final String? text;
  final Widget? child;
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
              width: isMobile() ? 150 : 200,
              height: isMobile() ? 50 : 60,
              fit: BoxFit.contain,
            ),

            // Text widget on top of the image
            child ??
                Text(
                  text ?? "",
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
