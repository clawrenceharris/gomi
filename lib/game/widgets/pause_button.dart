import 'package:flutter/material.dart';
import 'package:gomi/game/widgets/pause_menu_dialog.dart';

class PauseButton extends StatelessWidget {
  const PauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
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
