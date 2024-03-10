import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/game/components/entities/enemies/enemy.dart';
import 'package:gomi/game/components/entities/player.dart';

class BottleEnemy extends Enemy {
  late final double rangeNeg;
  late final double rangePos;
  final double offNeg;
  final double offPos;
  final double _speed = 70;

  @override
  double get speed => _speed;

  BottleEnemy({required this.offNeg, required this.offPos, super.position})
      : super(anchor: Anchor.topLeft) {
    direction = 1;
  }

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
    attack(dt);
    applyPhysics(dt, world);
    super.update(dt);
  }

  @override
  void attack(double dt) {
    if (position.x >= rangePos) {
      direction = -1;
    } else if (position.x <= rangeNeg) {
      direction = 1;
    }
    position.x += direction * speed * dt;
  }

  @override
  void playHitSfx() {
    game.audioController.playSfx(SfxType.plasticEnemy);
  }
}
