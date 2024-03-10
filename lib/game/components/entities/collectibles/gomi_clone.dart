import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/entities/collectibles/Collectible.dart';
import 'package:gomi/game/components/entities/physics_entity.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'package:gomi/game/gomi_game.dart';

class GomiClone extends Collectible with PhysicsEntity, HasGameRef<Gomi> {
  GomiClone({
    super.position,
    required this.color,
  }) : super(anchor: Anchor.topCenter);
  GomiColor color;
  @override
  FutureOr<void> onLoad() {
    SpriteAnimation idleAnimation = AnimationConfigs.gomi.idle(color.color);
    animation = idleAnimation;

    add(RectangleHitbox(collisionType: CollisionType.active));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    applyPhysics(dt, world);
    super.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      world.player.changeColor(color);
      game.audioController.playSfx(SfxType.gomiClone);
      removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void playSfx() {
    game.audioController.playSfx(SfxType.coin);
  }
}
