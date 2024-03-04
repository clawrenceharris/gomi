import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:gomi/game/widgets/button.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (KeyEvent event) {
          if (event.logicalKey == LogicalKeyboardKey.space) {
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
              child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.asset(
                    "assets/images/title.png",
                    width: Platform.isMacOS ||
                            Platform.isWindows ||
                            Platform.isLinux
                        ? 400
                        : 300,
                    height: 100,
                  )),
              Container(
                width: 600,
                height:
                    Platform.isMacOS || Platform.isWindows || Platform.isLinux
                        ? 360
                        : 200,
                decoration: const BoxDecoration(
                  color: Colors
                      .transparent, // Set the background color to transparent

                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/hud/menu_panel.png'), // Replace with your image path
                    fit: BoxFit.contain,
                  ),
                ),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Button(
                          onPressed: () {
                            GoRouter.of(context).go('/play');
                          },
                          text: "play"),
                      Button(
                          onPressed: () {
                            GoRouter.of(context).go('/instructions');
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
            ],
          )),
        ]));
  }
}
