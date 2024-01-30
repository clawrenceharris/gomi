import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/components/actors/player.dart';
import 'package:gomi/components/collisions/custom_hitbox.dart';
import 'package:gomi/gomi.dart';

class Seed extends SpriteAnimationComponent
    with HasGameRef<Gomi>, CollisionCallbacks {
  final String seed;
  Seed({
    this.seed = 'Oak Seed',
    position,
    size,
  }) : super(
          position: position,
          size: size,
        );

  bool _collected = false;
  final double stepTime = 0.1;
  final hitbox = CustomHitbox(offsetX: 0, offsetY: 0, width: 36, height: 34);

  @override
  FutureOr<void> onLoad() {
    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache('seed.png'),
        SpriteAnimationData.sequenced(
          amount: 11,
          stepTime: stepTime,
          textureSize: Vector2.all(22),
        ));

    add(RectangleHitbox(
        position: Vector2(hitbox.offsetX, hitbox.offsetY),
        size: Vector2(hitbox.width, hitbox.height),
        collisionType: CollisionType.passive));
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
