import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/entities/collectibles/Collectible.dart';
import 'package:gomi/game/components/entities/player.dart';

class GomiClone extends Collectible {
  GomiClone({
    super.position,
    required this.color,
  }) : super(
          animation: AnimationConfigs.gomi.idle(color.color),
        );
  GomiColor color;
  final double _gravity = 10;
  Vector2 velocity = Vector2.zero();
  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(collisionType: CollisionType.passive));
    return super.onLoad();
  }

  void _applyGravity(double dt) {
    velocity.y += _gravity;
    position.y += velocity.y * dt;
  }

  @override
  void update(double dt) {
    _checkVerticalCollisions();
    _applyGravity(dt);
    super.update(dt);
  }

  void _checkVerticalCollisions() {
    for (final block in world.collisionBlocks) {
      if (world.checkCollisionTopCenter(this, block)) {
        if (velocity.y > 0) {
          velocity.y = 0;
          position.y = block.y - height;

          break;
        }
        if (velocity.y < 0) {
          velocity.y = 0;
          position.y = block.y + block.height;
        }
      }
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      world.player.changeColor(color);
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
