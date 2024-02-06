import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gomi/game/widgets/button.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../settings/settings.dart';
import '../style/wobbly_button.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();
    void _handlePlayPress() {
      audioController.playSfx(SfxType.buttonTap);
      GoRouter.of(context).go('/play');
    }

    return Scaffold(
      backgroundColor: palette.backgroundMain.color,
      body: ResponsiveScreen(
        squarishMainArea: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _gap,
              Transform.rotate(
                angle: -0.1,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: const Text(
                    'A Flutter game template.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Press Start 2P',
                      fontSize: 32,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        rectangularMenuArea: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              buttonModel:
                  ButtonModel(onPressed: _handlePlayPress, text: "play"),
            ),
            _gap,
            Button(
              buttonModel:
                  ButtonModel(onPressed: _handlePlayPress, text: "help"),
            ),
            _gap,
            Button(
              buttonModel:
                  ButtonModel(onPressed: _handlePlayPress, text: "about"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: ValueListenableBuilder<bool>(
                valueListenable: settingsController.audioOn,
                builder: (context, audioOn, child) {
                  return IconButton(
                    onPressed: () => settingsController.toggleAudioOn(),
                    icon: Icon(audioOn ? Icons.volume_up : Icons.volume_off),
                  );
                },
              ),
            ),
            _gap,
            const Text('Built with Flame'),
          ],
        ),
      ),
    );
  }

  static const _gap = SizedBox(height: 10);
}
