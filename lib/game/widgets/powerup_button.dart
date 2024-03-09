import 'package:flutter/material.dart';
import 'package:gomi/game/components/powerup.dart';
import 'package:gomi/game/widgets/button.dart';
import 'package:gomi/player_stats/player_powerup.dart';
import 'package:gomi/player_stats/player_score.dart';
import 'package:provider/provider.dart';

class PowerupButton extends StatefulWidget {
  const PowerupButton({required this.powerup, super.key});
  final Powerup powerup;

  @override
  State<PowerupButton> createState() => _PowerupButton();
}

class _PowerupButton extends State<PowerupButton> {
  @override
  Widget build(BuildContext context) {
    final PlayerPowerup playerPowerup = context.watch<PlayerPowerup>();
    final PlayerScore playerScore = context.watch<PlayerScore>();

    late Widget child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.powerup.coins.toString(),
          style: const TextStyle(fontFamily: 'Pixel', color: Colors.white),
        ),
        const SizedBox(
          width: 5,
        ),
        Image.asset(
          "assets/images/collectibles/coin.png",
          width: 30,
          height: 30,
        )
      ],
    );

    if (playerPowerup.isEquipped(widget.powerup)) {
      child = const Text('Equipped!',
          style: TextStyle(fontFamily: 'Pixel', color: Colors.white));
    } else if (playerPowerup.hasPowerup(widget.powerup)) {
      child = const Text('Equip',
          style: TextStyle(fontFamily: 'Pixel', color: Colors.white));
    }

    return Button(
      child: child,
      onPressed: () {
        setState(() {
          //if we have the powerup and it is not equipped
          if (playerPowerup.hasPowerup(widget.powerup) &&
              !playerPowerup.isEquipped(widget.powerup)) {
            playerPowerup.equipPowerup(widget.powerup);
            // Update the button text
          } else if (!playerPowerup.hasPowerup(widget.powerup)) {
            if (widget.powerup.coins > playerScore.totalCoins.value) return;

            // Add the powerup to the available powerups
            playerPowerup.addPowerup(widget.powerup);

            playerScore.totalCoins.value -= widget.powerup.coins;
          } else if (playerPowerup.hasPowerup(widget.powerup) &&
              playerPowerup.isEquipped(widget.powerup)) {
            // Unequip the powerup
            playerPowerup.unequipPowerup(widget.powerup);
            // Update the button text
          }
        });
      },
    );
  }
}
