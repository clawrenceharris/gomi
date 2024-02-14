import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:gomi/audio/audio_controller.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/game/widgets/animated_text.dart';
import 'package:gomi/game/widgets/pause_button.dart';
import 'package:gomi/game/widgets/sound_button.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final audioController = context.watch<AudioController>();

    return RawKeyboardListener(
        autofocus: true, // Ensure the widget has focus
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
          if (event.logicalKey == LogicalKeyboardKey.space) {
            audioController.playSfx(SfxType.buttonTap);
            GoRouter.of(context).go('/play');
          }
        },
        child: Scaffold(
            body: Stack(
          children: [
            Positioned(
                child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                  fit: BoxFit.cover,
                  width: 1920,
                  height: 1080,
                  "assets/images/gomi_splash.png"),
            )),

            // Button positioned in the top right corner
            const Positioned(
              top: 10,
              right: 70,
              child: PauseButton(),
              //onPressed: () => GoRouter.of(context).push('/settings')
            ),

            const Positioned(
              top: 10,
              right: 10,
              child: SoundButton(),
            ),

            const Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedTextMovement(
                text: "press space to play",
              ),
            ),

            _gap,
          ],
        )));
  }

  static const _gap = SizedBox(height: 40);
}

class GradientTextWidget extends StatelessWidget {
  final String text;
  final List<Color> gradientColors;
  final double fontSize;

  const GradientTextWidget(
      {required this.text,
      required this.gradientColors,
      required this.fontSize,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white, // Text color on the gradient text
        ),
      ),
    );
  }
}
