import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flutter/animation.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/game/components/entities/collectibles/Collectible.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'package:gomi/game/gomi_game.dart';

class Coin extends Collectible with HasGameRef<Gomi> {
  Coin({super.position});
  final int points = 10;
  @override
  FutureOr<void> onLoad() async {
    size = Vector2.all(Globals.tileSize);
    animation = SpriteAnimation.fromFrameData(
        Flame.images.fromCache("collectibles/coin.png"),
        SpriteAnimationData.sequenced(
            amount: 1, stepTime: 0.05, textureSize: Vector2.all(64)));
    final moveEffect = MoveEffect.to(
        Vector2(position.x, position.y + -5),
        EffectController(
          alternate: true,
          curve: Curves.easeInOut,
          duration:
              2.5, // Total duration for the up-and-down movement (seconds)
          infinite: true,
        ));
    add(moveEffect);
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      other.playerScore.addCoin(points);
      game.audioController.playSfx(SfxType.coin);
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void playSfx() {
    game.audioController.playSfx(SfxType.coin);
  }
}
