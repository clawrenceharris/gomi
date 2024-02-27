import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/collisions/platforms/platform.dart';
import 'package:gomi/game/components/entities/gomi_entity.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'package:gomi/game/gomi_game.dart';
import 'package:gomi/game/gomi_level.dart';

class GomiClone extends GomiEntity
    with HasGameRef<Gomi>, HasWorldReference<GomiLevel>, CollisionCallbacks {
  GomiClone({
    super.position,
    required this.color,
  }) : super(anchor: Anchor.topCenter);
  GomiColor color;
  final double _gravity = 10;
  @override
  FutureOr<void> onLoad() {
    SpriteAnimation idleAnimation = AnimationConfigs.gomi.idle(color.color);
    animations = {GomiEntityState.idle: idleAnimation};
    current = GomiEntityState.idle;

    add(RectangleHitbox(collisionType: CollisionType.passive));
    return super.onLoad();
  }

  void _applyGravity(double dt) {
    velocity.y += _gravity;
    position.y += velocity.y * dt;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _applyGravity(dt);
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
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Platform) {
      if (world.checkCollisionTopCenter(this, other)) {
        position.y = other.y - height;
        velocity.y = 0;
      }
    }

    super.onCollision(intersectionPoints, other);
  }
}
