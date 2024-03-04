import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gomi/game/widgets/button.dart';
import 'package:gomi/router.dart';

class PauseMenuDialog extends StatelessWidget {
  const PauseMenuDialog({super.key});
  void _handleQuitButtonPress(BuildContext context) {
    router.go('/main_menu');
  }

  void _handleResumeButtonPress(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
        autofocus: true, // Ensure the widget has focus
        focusNode: FocusNode(),
        onKeyEvent: (KeyEvent event) {
          if (event.logicalKey == LogicalKeyboardKey.space) {
            Navigator.of(context).pop();
          }
        },
        child: AlertDialog(
          backgroundColor:
              Colors.transparent, // Make the background transparent
          content: Container(
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
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 40),

                    Stack(children: [
                      Text("game paused",
                          style: TextStyle(
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 5
                                ..color = Colors.lightBlue,
                              fontSize: 22,
                              fontFamily: 'Pixel',
                              fontWeight: FontWeight.bold)),
                      const Text("game paused",
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'Pixel',
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ]),

                    _gap,

                    Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                          Button(
                              onPressed: () =>
                                  _handleResumeButtonPress(context),
                              text: "resume"),
                          Button(
                              onPressed: () => _handleQuitButtonPress(context),
                              text: "quit"),
                          _gap,
                          Platform.isMacOS ||
                                  Platform.isWindows ||
                                  Platform.isLinux
                              ? const Text("press space to resume",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Pixel',
                                      fontWeight: FontWeight.normal))
                              : const SizedBox(width: 0, height: 0),
                          _gap
                        ]))
                    // Add more options as necessary
                  ],
                ),
              )),
        ));
  }

  static const _gap = SizedBox(height: 40);
}
