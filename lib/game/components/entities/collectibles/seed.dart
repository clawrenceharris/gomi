import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/widgets.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/entities/collectibles/Collectible.dart';

class Seed extends Collectible {
  Seed({
    required this.seed,
    super.position,
  });
  final String seed;
  final double stepTime = 0.1;

  @override
  FutureOr<void> onLoad() {
    animation = AnimationConfigs.seed.idle();
    add(MoveEffect.to(
        Vector2(position.x, position.y - 10),
        EffectController(
            infinite: true,
            duration: 2,
            alternate: true,
            curve: Curves.easeOutSine)));
    add(RectangleHitbox(collisionType: CollisionType.passive));
    return super.onLoad();
  }

  @override
  Future<void> collideWithPlayer() async {
    if (world.activeEnemies.isEmpty) {
      animation = AnimationConfigs.seed.disappearing();

      world.player.seedCollected = true;
      await Future.delayed(const Duration(seconds: 1));
      removeFromParent();
    }
  }
}
