import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gomi/game/widgets/button.dart';

class InstructionsText {
  static getStyle(Color color) {
    return TextStyle(fontFamily: 'Pixel', color: color, fontSize: 16);
  }
}

class InstructionsScreen extends StatelessWidget {
  const InstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
          width: 700,
          height: 400,
          decoration: const BoxDecoration(
            color:
                Colors.transparent, // Set the background color to transparent

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
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: RichText(
                    text: TextSpan(
                      style: InstructionsText.getStyle(
                          Colors.white), // Default text style
                      children: <TextSpan>[
                        const TextSpan(
                          text:
                              'Help Gomi collect Litter Critters that have polluted the land.\n\n Discard water bottles with  ',
                        ), // Regular text
                        TextSpan(
                            text: 'Blue Gomi.',
                            style: InstructionsText.getStyle(Colors.blue)),

                        const TextSpan(
                          text: '\n\nDispose of syringes with ',
                        ),

                        TextSpan(
                            text: 'Red Gomi.',
                            style: InstructionsText.getStyle(Colors.red)),
                        const TextSpan(
                          text: '\n\nCompost tomatoes with  ',
                        ),
                        TextSpan(
                            text: 'Green Gomi.',
                            style: InstructionsText.getStyle(Colors.green)),
                        const TextSpan(
                            text:
                                '\n\nAnd collect of broken light bulbs with '),

                        TextSpan(
                            text: 'Black Gomi.',
                            style: InstructionsText.getStyle(Colors.black54)),

                        const TextSpan(
                          text:
                              '\n\nWin by collecting the seed at the end of the level when all Litters Critters have been defeated',
                        ),
                      ],
                    ),
                  ),
                  // child: Text(
                  //     style: TextStyle( , .,
                  //         fontFamily: 'Pixel',
                  //         fontSize: 18,
                  //         color: Colors.white,
                  //         decoration: TextDecoration.none,
                  //         height: 2),
                  //     ""),
                ),
              ]))
          // Add more options as necessary
          ,
        ),
      ),
      Align(
          alignment: Alignment.topCenter,
          child: Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Stack(
                children: [
                  Text(
                    "how to play",
                    style: TextStyle(
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.lightBlue,
                        decoration: TextDecoration.none,
                        fontFamily: 'Pixel',
                        fontSize: 26),
                  ),
                  const Text(
                    "how to play",
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontFamily: 'Pixel',
                        fontSize: 26),
                  ),
                ],
              ))),
      Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Button(
              onPressed: () {
                GoRouter.of(context).go('/main_menu');
              },
              text: "back"),
        ),
      )
    ]);
  }
}
