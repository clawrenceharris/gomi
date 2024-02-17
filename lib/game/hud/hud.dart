import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/game/components/entities/player.dart';
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
    final playerLives = context.watch<PlayerLives>();

    const int margin = 10;
    const int padding = 3;
    return Stack(children: [
      Positioned(
          width: Globals.gomiWidth * Globals.maxLives +
              margin * 2 +
              padding * Globals.maxLives -
              1,
          height: Globals.gomiHeight + margin * 2,
          child: Image.asset("assets/images/hud/panel.png")),
      ValueListenableBuilder<int>(
        valueListenable: context.watch<PlayerLives>().getValueNotifier(),
        builder: (context, livesLeft, child) {
          int numberOfImagesToShow = (livesLeft % 3) + 1;
          List<Widget> imageWidgets = List.generate(numberOfImagesToShow, (_) {
            return Image.asset("assets/images/gomi/gomi.png");
          });
          return Row(
            children: imageWidgets,
          );
        },
      ),
    ]);
  }
}
