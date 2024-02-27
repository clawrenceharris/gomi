import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/game/components/entities/enemies/enemy.dart';
import 'package:gomi/game/components/entities/player.dart';

class BottleEnemy extends Enemy {
  double rangeNeg = 0;
  double rangePos = 0;
  final double offNeg;
  final double offPos;
  double _direction = 1;
  final double _speed = 70;

  BottleEnemy({required this.offNeg, required this.offPos, super.position})
      : super(anchor: Anchor.topLeft);

  @override
  void loadAllAnimations() {
    idleAnimation = AnimationConfigs.bottleEnemy.idle();

    attackAnimation = AnimationConfigs.bottleEnemy.attacking();
    current = EnemyState.attacking;
    super.loadAllAnimations();
  }

  @override
  bool playerIsCorrectColor() {
    return world.player.color == GomiColor.blue;
  }

  @override
  FutureOr<void> onLoad() {
    rangeNeg = position.x - offNeg * Globals.tileSize;
    rangePos = position.x + offPos * Globals.tileSize;
    isAttacking = true;
    add(RectangleHitbox(collisionType: CollisionType.passive));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _attack(dt);

    super.update(dt);
  }

  void _attack(double dt) {
    if (position.x >= rangePos) {
      _direction = -1;
    } else if (position.x <= rangeNeg) {
      _direction = 1;
    }
    position.x += _direction * _speed * dt;
  }
}
