import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/entities/collectibles/Collectible.dart';

class Seed extends Collectible {
  Seed({
    required this.seed,
    super.position,
  });
  final String seed;
  final double stepTime = 0.1;
  final Vector2 seedSize = Vector2(44, 52);
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation growingAnimation;

  @override
  FutureOr<void> onLoad() {
    loadAllAnimations();
    animation = idleAnimation;
    add(RectangleHitbox(collisionType: CollisionType.passive));
    return super.onLoad();
  }

  @override
  Future<void> collideWithPlayer() async {
    animation = growingAnimation;
    if (world.activeEnemies.isEmpty && !world.player.seedCollected) {
      animation = AnimationConfigs.seed.growing();
      world.player.seedCollected = true;
    }
  }

  void loadAllAnimations() {
    idleAnimation = AnimationConfigs.seed.idle();
    growingAnimation = AnimationConfigs.seed.growing();
  }
}
