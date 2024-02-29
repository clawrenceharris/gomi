import 'package:flutter/material.dart';
import 'package:gomi/settings/settings.dart';
import 'package:provider/provider.dart';

class SoundButton extends StatelessWidget {
  const SoundButton({super.key});
  @override
  Widget build(BuildContext context) {
    final settingsController = context.watch<SettingsController>();

    return ValueListenableBuilder<bool>(
        valueListenable: settingsController.audioOn,
        builder: (context, audioOn, child) {
          return // Handle hover events
              TextButton(
                  onPressed: () {
                    settingsController.toggleSoundsOn();
                    settingsController.toggleMusicOn();

                    // Add your button's action here
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      // Set the border radius
                    ),
                  ),
                  child: Image.asset("assets/images/hud/sound_button.png"));
        });
  }
}
