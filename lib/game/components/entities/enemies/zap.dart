import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/entities/player.dart';

class Zap extends SpriteAnimationComponent with CollisionCallbacks {
  final int direction;
  final _speed = 60;
  double elapsedTime = 0.0;
  double activeTime = 9;
  Zap({super.position, super.size, required this.direction})
      : super(animation: AnimationConfigs.bulbEnemy.zap());

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    elapsedTime += dt;
    position.x += direction * _speed * dt;
    if (elapsedTime >= activeTime) {
      removeFromParent();
    }
    super.update(dt);
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
