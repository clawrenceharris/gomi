import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/game/widgets/pause_button.dart';
import 'package:gomi/game/widgets/sound_button.dart';
import 'package:gomi/player_stats/player_health.dart';
import 'package:gomi/player_stats/player_score.dart';
import 'package:provider/provider.dart';

class Hud extends StatelessWidget {
  Hud({super.key});
  final List<SpriteComponent> lifeIndicators = [];

  // void _addLifeIndicators() async {
  //   final gomiImage = await Flame.images.load("gomi/gomi.png");

  //   for (int i = 0; i < game.world.player.lives.value; i++) {
  //     final lifeIndicator = SpriteComponent(
  //         anchor: Anchor.topCenter,
  //         position: Vector2((game.size.x - 30) - i * 25, 20),
  //         sprite: Sprite(gomiImage));
  //     game.world.add(lifeIndicator);
  //     lifeIndicators.add(lifeIndicator);
  //   }
  // }

  // void updateLifeIndicators() async {
  //   final lives = game.world.player.lives.value as int;
  //   if (lives < Globals.maxLives) {
  //     // Calculate the index of the life indicator to remove
  //     final indexToRemove = lifeIndicators.length - 1 - lives;
  //     if (indexToRemove >= 0 && indexToRemove < lifeIndicators.length) {
  //       // Remove the life indicator at the calculated index
  //       lifeIndicators[indexToRemove].removeFromParent();
  //     }
  //   } else {
  //     _addLifeIndicators();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final playerHealth = context.watch<PlayerHealth>();
    final playerScore = context.watch<PlayerScore>();

    const int margin = 10;
    const int padding = 5;
    return Stack(children: [
      ValueListenableBuilder<int>(
          valueListenable: playerScore.coins,
          builder: (context, coins, child) {
            return Positioned(
                top: 10,
                left: 10,
                child: Row(children: [
                  Image.asset(
                    "assets/images/collectibles/coin.png",
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 8),
                  Stack(
                    children: [
                      // Background text with stroke
                      Text(
                        "x${coins.toString().padLeft(2, '0')}",
                        style: TextStyle(
                          fontSize: 22,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 5
                            ..color = Colors.black,
                        ),
                      ),
                      // Foreground text
                      Text(
                        "x${coins.toString().padLeft(2, '0')}",
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ]));
          }),
      ValueListenableBuilder<int>(
        valueListenable: playerHealth.lives,
        builder: (context, playerLives, child) {
          List<Widget> imageWidgets = List.generate(playerLives, (_) {
            return Row(children: [
              Image.asset("assets/images/gomi/gomi.png"),
              const SizedBox(
                width: 5,
              )
            ]);
          });

          return Positioned(
              bottom: 10,
              left: 10,
              child: Stack(children: [
                Image.asset(
                  fit: BoxFit.fill,
                  "assets/images/hud/panel.png",
                  width: Globals.gomiWidth * Globals.maxLives +
                      (margin * 2) +
                      padding * (Globals.maxLives - 1),
                  height: Globals.gomiHeight + margin * 2,
                ),
                Positioned(
                    left: 10,
                    top: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: imageWidgets,
                    ))
              ]));
        },
      ),
      const Positioned(
          top: 10,
          right: 10,
          child: Row(children: [
            PauseButton(),
            SoundButton(),
          ]))
    ]);
  }
}
