import 'dart:async';

import 'package:flame/components.dart';
import 'package:gomi/game/gomi_game.dart';

class Hud extends Component with HasGameRef<Gomi> {
  Hud({super.children});

  @override
  FutureOr<void> onLoad() {
    final scoreText =
        TextComponent(text: "score: 0", position: Vector2.all(10));
    add(scoreText);

    final livesText = TextComponent(
        text: "x5",
        anchor: Anchor.topRight,
        position: Vector2(gameRef.size.x - 10, 10));
    add(livesText);
    return super.onLoad();
  }
}
