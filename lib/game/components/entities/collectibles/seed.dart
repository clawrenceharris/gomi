import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/widgets.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/entities/collectibles/Collectible.dart';

class Seed extends Collectible {
  Seed({
    super.position,
  });
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation growingAnimation;
  late final MoveEffect moveEffect;
  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    animation = idleAnimation;
    add(RectangleHitbox(collisionType: CollisionType.passive));
    moveEffect = MoveEffect.to(
        Vector2(position.x, position.y - 10),
        EffectController(
            duration: 2,
            alternate: true,
            infinite: true,
            curve: Curves.easeInOut));

    add(moveEffect);
    return super.onLoad();
  }

  @override
  Future<void> collideWithPlayer() async {
    if (world.activeEnemies.isEmpty) {
      animation = growingAnimation;
      position = Vector2(startingPosition.x, startingPosition.y);
      remove(moveEffect);
      world.player.seedCollected = true;
    }
  }

  void _loadAllAnimations() {
    idleAnimation = AnimationConfigs.seed.idle();
    growingAnimation = AnimationConfigs.seed.growing();
  }
}
