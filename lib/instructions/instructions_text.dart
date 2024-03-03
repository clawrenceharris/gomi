import 'package:flutter/material.dart';

class InstructionsText {
  static getStyle({Color color = Colors.white}) {
    return TextStyle(
        fontFamily: 'Pixel',
        color: color,
        fontSize: 16,
        decoration: TextDecoration.none);
  }
}

final List<Widget> instructionTexts = [
  Text(
      "Help Gomi collect Litter Critters that have polluted the land!\n\nDefeat Litter Critters by jumping on top of them...But be sure you've procured the right color!",
      style: InstructionsText.getStyle()),
  Text(
      "Use the left and right arrow keys to walk.\n\nUse the up arrow or sapce to jump.",
      style: InstructionsText.getStyle()),
  RichText(
    text: TextSpan(
      style:
          InstructionsText.getStyle(color: Colors.white), // Default text style
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
    text: TextSpan(
      style:
          InstructionsText.getStyle(color: Colors.white), // Default text style
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
  RichText(
    text: TextSpan(
      style:
          InstructionsText.getStyle(color: Colors.white), // Default text style
      children: <TextSpan>[
        const TextSpan(text: 'trash broken light bulbs with '),
        TextSpan(
            text: 'Black Gomi.',
            style: InstructionsText.getStyle(color: Colors.black54)),
      ],
    ),
  ),
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
