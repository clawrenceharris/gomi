import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gomi/audio/audio_controller.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/game/utils.dart';
import 'package:gomi/game/widgets/animated_text.dart';
import 'package:gomi/settings/settings.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final audioController = context.watch<AudioController>();
    final settingsController = context.watch<SettingsController>();
    settingsController.toggleAudioOn();

    return GestureDetector(
        onTapUp: (details) {
          audioController.playSfx(SfxType.buttonTap);
          GoRouter.of(context).go('/play');
        },
        child: Scaffold(
            backgroundColor: Colors.lightBlue,
            body: Stack(
              children: [
                Positioned(
                    child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                      fit: BoxFit.contain, "assets/images/splash.png"),
                )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedTextMovement(
                    text: isMobile() ? "tap to play" : "click to play",
                  ),
                ),
                _gap,
              ],
            )));
  }

  static const _gap = SizedBox(height: 40);
}
