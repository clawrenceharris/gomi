import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/entities/enemies/enemy.dart';
import 'package:gomi/game/components/entities/enemies/sparks.dart';
import 'package:gomi/game/components/entities/enemies/zap.dart';

class BulbEnemy extends Enemy {
  final int direction;
  BulbEnemy({required this.direction, super.position, required super.player});
  double _elapsedTime = 0.0; // Accumulated time for the current state
  double zapCoolDown = 3;
  late final SpriteAnimationComponent sparks;
  @override
  FutureOr<void> onLoad() {
    sparks = Sparks(position: Vector2(position.x + 10, position.y + 3));
    final moveEffect = MoveEffect.to(
        Vector2(position.x, position.y + -10),
        EffectController(
          alternate: true,
          duration:
              2.0, // Total duration for the up-and-down movement (seconds)
          infinite: true,
        ));
    add(moveEffect);
    return super.onLoad();
  }

  @override
  bool playerIsCorrectColor() {
    return player.color.toLowerCase() == "black";
  }

  @override
  void onRemove() {
    sparks.removeFromParent();
    super.onRemove();
  }

  @override
  void attack(double dt) {
    sparks.position = Vector2(position.x + 8, position.y - 8);
    _elapsedTime += dt;
    if (_elapsedTime >= zapCoolDown) {
      game.world.add(Zap(
          position: Vector2(position.x, position.y + height / 2),
          direction: direction));
      _elapsedTime = 0.0;
    }
  }

  @override
  void update(double dt) {
    if (isAttacking && elapsedTime >= attackTime) {
      switchToIdle();
      sparks.removeFromParent();
    } else if (!isAttacking && elapsedTime >= idleTime) {
      switchToAttack();
      game.world.add(sparks);
    }
    super.update(dt);
  }

  @override
  void loadAllAnimations() {
    idleAnimation = AnimationConfigs.bulbEnemy.idle();
    attackAnimation = AnimationConfigs.bulbEnemy.attacking();
    super.loadAllAnimations();
  }
}
