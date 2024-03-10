import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gomi/game/widgets/button.dart';
import 'package:gomi/instructions/instructions_text.dart';
import 'package:gomi/utils.dart';

class InstructionsScreen extends StatefulWidget {
  const InstructionsScreen({super.key});

  @override
  State<InstructionsScreen> createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  int currentIndex = 0;

  void showNextInstruction() {
    setState(() {
      currentIndex = (currentIndex + 1) % instructionTexts.length;
    });
  }

  void showPreviousInstruction() {
    setState(() {
      currentIndex = (currentIndex - 1) % instructionTexts.length;
      if (currentIndex < 0) {
        currentIndex = instructionTexts.length - 1;
      }
    });
  }

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
          height: !isMobile() ? 400 : 300,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage('assets/images/hud/menu_panel.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
              child: Column(
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Stack(
                        children: [
                          Text(
                            "how to play",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 5
                                ..color = Colors.lightBlue,
                              decoration: TextDecoration.none,
                              fontFamily: 'Pixel',
                              fontSize: 26,
                            ),
                          ),
                          const Text(
                            "how to play",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontFamily: 'Pixel',
                              fontSize: 26,
                            ),
                          ),
                        ],
                      ))),
              Padding(
                padding: const EdgeInsets.all(40),
                child: instructionTexts[currentIndex],
              )
            ],
          )),
        ),
      ),
      SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Button(
                onPressed: () {
                  if (currentIndex > 0) {
                    showPreviousInstruction();
                  } else {
                    GoRouter.of(context).go('/main_menu');
                  }
                },
                text: "back"),
          ),
        ),
      ),
      SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Button(
                onPressed: () {
                  if (currentIndex < instructionTexts.length - 1) {
                    showNextInstruction();
                  }
                },
                text: "next"),
          ),
        ),
      )
    ]);
  }
}
