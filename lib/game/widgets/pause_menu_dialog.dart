import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gomi/game/widgets/button.dart';
import 'package:gomi/game/widgets/resume_button.dart';

class PauseMenuDialog extends StatelessWidget {
  const PauseMenuDialog({super.key});
  void _handleQuitButtonPress(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
        autofocus: true, // Ensure the widget has focus
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
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
                    const Text("Game Paused",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    _gap,

                    Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                          const ResumeButton(),
                          Button(
                              buttonModel: ButtonModel(
                                  onPressed: () =>
                                      _handleQuitButtonPress(context),
                                  text: "quit")),
                          _gap,
                          const Text("press space to resume",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal)),
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
