import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:gomi/game/widgets/button.dart';
import 'package:gomi/level_selection/instructions_screen.dart';
import 'package:gomi/router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final audioController = context.watch<AudioController>();
    return KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (KeyEvent event) {
          if (event.logicalKey == LogicalKeyboardKey.space) {
            audioController.playSfx(SfxType.buttonTap);
            GoRouter.of(context).go('/play');
          }
        },
        child: Stack(children: [
          Positioned(
              child: Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
                fit: BoxFit.cover,
                width: 1920,
                height: 1080,
                "assets/images/main_menu_bg.png"),
          )),
          Center(
            child: Container(
              width: 600,
              height: 360,
              decoration: const BoxDecoration(
                color: Colors
                    .transparent, // Set the background color to transparent

                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/hud/menu_panel.png'), // Replace with your image path
                  fit: BoxFit.fill,
                ),
              ),
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Button(
                        onPressed: () {
                          GoRouter.of(context).go('/play');
                          audioController.playSfx(SfxType.buttonTap);
                        },
                        text: "play"),
                    Button(
                        onPressed: () {
                          GoRouter.of(context).go('/instructions');
                          audioController.playSfx(SfxType.buttonTap);
                        },
                        text: "help"),
                    Button(
                        onPressed: () {
                          GoRouter.of(context).go('/credits');
                        },
                        text: "credits"),
                  ]))
              // Add more options as necessary
              ,
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Image.asset(
                    "assets/images/title.png",
                    width: 500,
                    height: 200,
                  ))),
        ]));
  }
}
