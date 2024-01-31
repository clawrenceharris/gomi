import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'package:gomi/game/gomi_game.dart';

class Seed extends SpriteAnimationComponent
    with HasGameRef<Gomi>, CollisionCallbacks {
  Seed({
    required this.seed,
    position,
    size,
  }) : super(
          position: position,
          size: size,
        );
  final String seed;
  final hitbox = RectangleHitbox(collisionType: CollisionType.passive);
  bool _collected = false;
  final double stepTime = 0.1;

  @override
  FutureOr<void> onLoad() {
    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache('seed.png'),
        SpriteAnimationData.sequenced(
          amount: 11,
          stepTime: stepTime,
          textureSize: Vector2.all(22),
        ));

    add(hitbox);
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      collidedWithPlayer();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  void collidedWithPlayer() {
    if (!_collected) {
      animation = SpriteAnimation.fromFrameData(
          game.images.fromCache('collected.png'),
          SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: stepTime,
            textureSize: Vector2.all(22),
          ));

      _collected = true;
    }

    Future.delayed(
      const Duration(milliseconds: 500),
      () => removeFromParent(),
    );
  }
}
