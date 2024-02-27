import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/entities/collectibles/Collectible.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'package:gomi/game/gomi_game.dart';

class GomiClone extends Collectible with HasGameRef<Gomi> {
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
    super.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      world.player.changeColor(color);
      game.audioController.playSfx(SfxType.gomiClone);
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
