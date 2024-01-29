import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/components/actors/enemy.dart';
import 'package:gomi/components/actors/player.dart';
import 'package:gomi/constants/globals.dart';

class TomatoEnemy extends Enemy with HasCollisionDetection, CollisionCallbacks {
  final double attackHeight;
  late double _bottomY;
  late double _topY;
  double _direction = -1;
  final double enemyHeight = 32;

  TomatoEnemy({super.position, this.attackHeight = 0});

  @override
  FutureOr<void> onLoad() {
    _bottomY = attackHeight - enemyHeight;
    _topY = position.y;
    position.y += _bottomY;
    return super.onLoad();
  }

  final double _speed = 50;

  @override
  void loadAllAnimations() {
    idleAnimation = spriteAnimation("Idle", 1, Vector2(26, 34));
    super.loadAllAnimations();

    animations = {
      EnemyState.idle: idleAnimation,
      EnemyState.attacking: idleAnimation,
    };
  }

  @override
  SpriteAnimation spriteAnimation(
      String state, int amount, Vector2 textureSize) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache('Enemies/Tomato/$state.png'),
        SpriteAnimationData.sequenced(
            amount: amount,
            stepTime: Globals.animationStepTime,
            textureSize: textureSize));
  }

  void _attack(dt) {
    // Check if the enemy has reached the end or start position
    if (_direction == -1 && position.y <= _topY) {
      _direction = 1; // Change direction to down
    } else if (_direction == 1 && position.y > _topY + _bottomY) {
      _direction = -1; // Change direction to right
    }

    // Update the position based on speed and direction
    position.y += _speed * _direction * dt;
  }

  @override
  void update(double dt) {
    super.update(dt);
    elapsedTime += dt;

    // Check if it's time to switch states
    if (isAttacking && elapsedTime >= attackTime) {
      switchToIdle();
    } else if (!isAttacking && elapsedTime >= idleTime) {
      switchToAttack();
    }

    // Check if enemy is attacking
    if (isAttacking) {
      _attack(dt);
    }
  }

  void switchToIdle() {
    isAttacking = false;
    elapsedTime = 0.0; // Reset the elapsed time for the new state
    current = EnemyState.idle;
  }

  void switchToAttack() {
    isAttacking = true;
    elapsedTime = 0.0; // Reset the elapsed time for the new state
    current = EnemyState.attacking;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      // interact with player
      switch (current) {
        case EnemyState.attacking:
          //TODO: attack the player
          break;
        case EnemyState.idle:
          //TODO: remove enemy from game
          super.remove(this);
          break;
        default:
          break;
      }
    }
    super.onCollision(intersectionPoints, other);
  }
}
