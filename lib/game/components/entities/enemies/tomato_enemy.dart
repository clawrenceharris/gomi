import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/entities/enemies/enemy.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'package:gomi/game/gomi_game.dart';

class TomatoEnemy extends Enemy with HasGameReference<Gomi> {
  final double _gravity = 10;
  final double jumpForce;
  final double enemyHeight = 32;
  final double _maxVelocity = 200;
  double _elapsedTime = 0.0;
  final double bounceCoolDown = 1;
  bool isGrounded = true;
  Vector2 velocity = Vector2.zero();
  TomatoEnemy({
    super.position,
    this.jumpForce = 360,
  });

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(collisionType: CollisionType.passive));
    sfx = SfxType.compostEnemy;
    attackTime = 10;
    return super.onLoad();
  }

  @override
  void loadAllAnimations() {
    idleAnimation = AnimationConfigs.tomatoEnemy.idle();
    attackAnimation = AnimationConfigs.tomatoEnemy.attacking();
    current = EnemyState.attacking;
    super.loadAllAnimations();
  }

  @override
  void playDeathSfx(SfxType sfx) {
    game.audioController.playSfx(sfx);
  }

  void _applyGravity(double dt) {
    velocity.y += _gravity;
    velocity.y = velocity.y.clamp(-jumpForce, _maxVelocity);
  }

  void _attack(dt) {
    _elapsedTime += dt;

    if (isGrounded && _elapsedTime >= bounceCoolDown) {
      _jump(dt);

      _elapsedTime = 0.0;
    }
  }

  void _jump(double dt) {
    velocity.y = -jumpForce;

    isGrounded = false;
  }

  @override
  bool playerIsCorrectColor() {
    return world.player.color == GomiColor.green;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _applyGravity(dt);
    _attack(dt);

    position.y += velocity.y * dt;
  }
}
