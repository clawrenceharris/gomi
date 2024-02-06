import 'package:flutter/material.dart';

class SoundButton extends StatelessWidget {
  const SoundButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        // Handle hover events
        child: TextButton(
            onPressed: () {
              // Add your button's action here
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                // Set the border radius
              ),
            ),
            child: Image.asset("assets/images/hud/sound_button.png")));
  }
}
