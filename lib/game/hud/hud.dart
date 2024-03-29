import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'package:gomi/game/hud/controls.dart';
import 'package:gomi/game/widgets/pause_button.dart';
import 'package:gomi/game/widgets/powerups_menu_dialog.dart';
import 'package:gomi/game/widgets/sound_button.dart';
import 'package:gomi/player_stats/player_health.dart';
import 'package:gomi/player_stats/player_score.dart';
import 'package:gomi/utils.dart';
import 'package:provider/provider.dart';

class Hud extends StatelessWidget {
  Hud({super.key, required this.player});
  final Player player;
  final List<SpriteComponent> lifeIndicators = [];

  @override
  Widget build(BuildContext context) {
    final playerHealth = context.watch<PlayerHealth>();
    final playerScore = context.watch<PlayerScore>();

    const int margin = 10;
    const int padding = 5;
    return Stack(children: [
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: isMobile()
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 16.0),
                      ControlButton(
                        image: 'assets/images/hud/left_arrow.png',
                        onTapDown: (TapDownDetails details) {
                          player.direction = -1;
                        },
                        onTapUp: (TapUpDetails details) {
                          player.direction = 0;
                        },
                      ),
                      ControlButton(
                        image: 'assets/images/hud/right_arrow.png',
                        onTapDown: (TapDownDetails details) {
                          player.direction = 1;
                        },
                        onTapUp: (TapUpDetails details) {
                          player.direction = 0;
                        },
                      ),
                      ControlButton(
                        image: 'assets/images/hud/up_arrow.png',
                        onTapDown: (TapDownDetails details) {
                          player.hasJumped = true;
                        },
                        onTapUp: (TapUpDetails details) {
                          player.hasJumped = false;
                        },
                      ),
                    ],
                  )
                : const SizedBox(),
          )),
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
                          fontFamily: 'Pixel',
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
                          fontFamily: 'Pixel',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const PowerupsMenuDialog();
                          });
                    },
                    child: Image.asset(
                      "assets/images/hud/power_up_button.png",
                      width: 40,
                      height: 40,
                    ),
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
