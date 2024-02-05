import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/entities/player.dart';

class Sparks extends SpriteAnimationComponent with CollisionCallbacks {
  Sparks({super.position, super.size})
      : super(
            anchor: Anchor.topCenter,
            animation: AnimationConfigs.bulbEnemy.sparks());

  @override
  FutureOr<void> onLoad() {
    add(CircleHitbox());

    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      other.collidedWithEnemy();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
