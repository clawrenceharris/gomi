import 'dart:async';
import 'package:flame/components.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/entities/enemies/enemy.dart';
import 'package:gomi/game/gomi_game.dart';

class TomatoEnemy extends Enemy with HasGameReference<Gomi> {
  final double _gravity = 10;
  final double _jumpForce = 360;
  final double enemyHeight = 32;
  final double _maxVelocity = 200;
  double _elapsedTime = 0.0;
  final double bounceCoolDown = 1;
  bool isGrounded = true;
  Vector2 velocity = Vector2.zero();
  TomatoEnemy({
    super.position,
    required super.player,
  });

  @override
  FutureOr<void> onLoad() {
    //debugMode = true;
    attackTime = 10;
    return super.onLoad();
  }

  @override
  void loadAllAnimations() {
    idleAnimation = AnimationConfigs.tomatoEnemy.idle();
    attackAnimation = AnimationConfigs.tomatoEnemy.attacking();
    super.loadAllAnimations();
  }

  void _applyGravity(double dt) {
    velocity.y += _gravity;
    velocity.y = velocity.y.clamp(-_jumpForce, _maxVelocity);
  }

  @override
  void attack(dt) {
    _elapsedTime += dt;

    if (isGrounded && _elapsedTime >= bounceCoolDown) {
      _jump(dt);

      _elapsedTime = 0.0;
    }
  }

  void _jump(double dt) {
    velocity.y = -_jumpForce;

    isGrounded = false;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _applyGravity(dt);
    _checkVerticalCollisions();
    elapsedTime += dt;

    position.y += velocity.y * dt;

    // Check if it's time to switch states
    if (isAttacking && elapsedTime >= attackTime) {
      switchToIdle();
    } else if (!isAttacking && elapsedTime >= idleTime) {
      switchToAttack();
    }
  }

  void _checkVerticalCollisions() {
    for (final block in game.world.collisionBlocks) {
      if (game.world.checkCollision(block, this)) {
        if (velocity.y > 0) {
          velocity.y = 0;
          position.y = block.y - height;
          isGrounded = true;
          break;
        }
      }
    }
  }
}
