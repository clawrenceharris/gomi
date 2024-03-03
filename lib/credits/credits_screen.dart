import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gomi/game/widgets/button.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

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
          height: 360,
          decoration: const BoxDecoration(
            color:
                Colors.transparent, // Set the background color to transparent

            image: DecorationImage(
              image: AssetImage(
                  'assets/images/hud/menu_panel.png'), // Replace with your image path
              fit: BoxFit.fill,
            ),
          ),
          child: const Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Padding(
                  padding: EdgeInsets.all(40),
                  child: Text("Created by:\n\n Caleb Harris\nAngel Santiago",
                      style: TextStyle(
                          fontFamily: 'Pixel',
                          fontSize: 18,
                          decoration: TextDecoration.none,
                          color: Colors.white)),
                ),
                // child: Text(
                //     style: TextStyle( , .,
                //         fontFamily: 'Pixel',
                //         fontSize: 18,
                //         color: Colors.white,
                //         decoration: TextDecoration.none,
                //         height: 2),
                //     ""),
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
                    "credits",
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
                    "credits",
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
