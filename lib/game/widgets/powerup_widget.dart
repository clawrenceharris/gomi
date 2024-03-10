import 'package:flutter/material.dart';
import 'package:gomi/game/components/powerups/powerup.dart';
import 'package:gomi/game/widgets/powerup_button.dart';

class PowerupWidget extends StatefulWidget {
  const PowerupWidget({required this.powerup, super.key});
  final Powerup powerup;

  @override
  State<PowerupWidget> createState() => _PowerupWidgetState();
}

class _PowerupWidgetState extends State<PowerupWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          widget.powerup.name,
          style: const TextStyle(
              fontFamily: 'Pixel', fontSize: 18, color: Colors.white),
        ),
        const SizedBox(
          height: 20,
        ),
        Transform.scale(
          scale: 3,
          child: Image.asset(
            "assets/images/${widget.powerup.image}",
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "${widget.powerup.description}\nPress space to activate.",
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontFamily: 'Pixel', fontSize: 12, color: Colors.white),
        ),
        PowerupButton(powerup: widget.powerup)
      ],
    );
  }
}
