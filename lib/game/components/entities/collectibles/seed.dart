import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/constants/animation_configs.dart';
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
  final Vector2 seedSize = Vector2(44, 52);
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation growingAnimation;

  @override
  FutureOr<void> onLoad() {
    loadAllAnimations();
    animation = idleAnimation;
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
      animation = growingAnimation;

      _collected = true;
    }
  }

  void loadAllAnimations() {
    idleAnimation = AnimationConfigs.seed.idle();
    growingAnimation = AnimationConfigs.seed.growing();
  }
}
