import 'dart:async';

import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/game/components/entities/enemies/enemy.dart';

class BottleEnemy extends Enemy {
  double rangeNeg = 0;
  double rangePos = 0;
  final int offNeg;
  final int offPos;
  double _direction = 1;
  final double _speed = 90;

  BottleEnemy({
    super.position,
    required this.offNeg,
    required this.offPos,
    required super.player,
  });

  @override
  void loadAllAnimations() {
    idleAnimation = AnimationConfigs.bottleEnemy.idle();

    attackAnimation = AnimationConfigs.bottleEnemy.attacking();
    super.loadAllAnimations();
  }

  @override
  FutureOr<void> onLoad() {
    rangeNeg = position.x - offNeg * Globals.tileSize;
    rangePos = position.x + offPos * Globals.tileSize;
    print("rangeNeg: $rangeNeg rangePos: $rangePos");
    return super.onLoad();
  }

  @override
  void attack(double dt) {
    _move(dt);
  }

  void _move(double dt) {
    if (position.x >= rangePos) {
      _direction = -1;
    } else if (position.x <= rangeNeg) {
      _direction = 1;
    }
    position.x += _direction * _speed * dt;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Check if it's time to switch states
    if (isAttacking && elapsedTime >= attackTime) {
      switchToIdle();
    } else if (!isAttacking && elapsedTime >= idleTime) {
      switchToAttack();
    }
  }

  @override
  void switchToAttack() {
    super.switchToAttack();
    _direction *= -1;
  }
}
