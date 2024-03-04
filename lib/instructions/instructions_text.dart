import 'package:flutter/material.dart';

class InstructionsText {
  static TextStyle getStyle({Color color = Colors.white, Paint? foreground}) {
    return TextStyle(
        fontFamily: 'Pixel',
        color: foreground == null ? color : null,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        foreground: foreground,
        decoration: TextDecoration.none);
  }
}

final List<Widget> instructionTexts = [
  Text(
      textAlign: TextAlign.center,
      "Help Gomi collect Litter Critters that have polluted the land!\n\nDefeat Litter Critters by jumping on top of them...But be sure you've procured the right color!",
      style: InstructionsText.getStyle()),
  Text(
      "Use the left and right arrow keys to walk.\n\nUse the up arrow or sapce to jump.",
      style: InstructionsText.getStyle()),
  RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      style: InstructionsText.getStyle(), // Default text style
      children: <TextSpan>[
        const TextSpan(
          text: 'Discard water bottles with ',
        ), // Regular text
        TextSpan(
            text: 'Blue Gomi.',
            style: InstructionsText.getStyle(color: Colors.blue)),
      ],
    ),
  ),
  RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      style: InstructionsText.getStyle(), // Default text style
      children: <TextSpan>[
        const TextSpan(
          text: 'Compost tomatoes with  ',
        ),
        TextSpan(
            text: 'Green Gomi.',
            style: InstructionsText.getStyle(color: Colors.green)),
      ],
    ),
  ),
  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        textAlign: TextAlign.center,
        'trash broken light bulbs with ',
        style: InstructionsText.getStyle(),
      ),
      Stack(
        children: [
          Text('Black Gomi.',
              textAlign: TextAlign.center,
              style: InstructionsText.getStyle(
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 5
                  ..color = Colors.white,
              )),
          Text('Black Gomi.',
              textAlign: TextAlign.center,
              style: InstructionsText.getStyle(color: Colors.black38)),
        ],
      )
    ],
  ),
  // Default text style

  RichText(
    text: TextSpan(
      style:
          InstructionsText.getStyle(color: Colors.white), // Default text style
      children: <TextSpan>[
        const TextSpan(
          text: 'And dispose of syringes with ',
        ),
        TextSpan(
            text: 'Red Gomi.',
            style: InstructionsText.getStyle(color: Colors.red)),
      ],
    ),
  ),
];
