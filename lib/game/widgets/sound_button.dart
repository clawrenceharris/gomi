import 'package:flutter/material.dart';
import 'package:gomi/audio/audio_controller.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/settings/settings.dart';
import 'package:provider/provider.dart';

class SoundButton extends StatelessWidget {
  const SoundButton({super.key});
  @override
  Widget build(BuildContext context) {
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();
    return ValueListenableBuilder<bool>(
        valueListenable: settingsController.audioOn,
        builder: (context, audioOn, child) {
          return // Handle hover events
              TextButton(
                  onPressed: () {
                    audioController.playSfx(SfxType.buttonTap);
                    settingsController.toggleAudioOn();

                    // Add your button's action here
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    // Set the border radius
                  ),
                  child: Image.asset("assets/images/hud/sound_button.png"));
        });
  }
}
