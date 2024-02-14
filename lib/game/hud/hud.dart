import 'dart:async';

import 'package:flame/components.dart';
import 'package:gomi/game/gomi_game.dart';

class Hud extends Component with HasGameRef<Gomi> {
  Hud({super.children});
  late TextComponent scoreText;

  @override
  FutureOr<void> onLoad() {
    game.world.scoreNotifier.addListener(_onScoreChange);
    scoreText = TextComponent(
        text: "score: ${game.world.scoreNotifier.value}",
        position: Vector2.all(10));
    add(scoreText);

    final livesText = TextComponent(
        text: "x5",
        anchor: Anchor.bottomLeft,
        position: Vector2(10, game.size.y - 10));
    add(livesText);
    return super.onLoad();
  }

  void _onScoreChange() {
    scoreText.text = game.world.scoreNotifier.value.toString();
  }
}
