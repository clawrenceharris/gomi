import 'package:flutter/material.dart';
import 'package:gomi/audio/audio_controller.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/game/widgets/pause_menu_dialog.dart';
import 'package:provider/provider.dart';

class PauseButton extends StatelessWidget {
  const PauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    final audioController = context.watch<AudioController>();

    return TextButton(
        onPressed: () {
          audioController.playSfx(SfxType.buttonTap);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const PauseMenuDialog(); // Create and return an instance of PauseMenuDialog
            },
          );
          // Add your button's action here
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: Image.asset(
            "assets/images/hud/pause_button.png") // Replace with your image path
        );
  }
}
