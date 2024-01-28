import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gomi/components/actors/enemy.dart';
import 'package:gomi/components/actors/player.dart';
import 'package:gomi/constants/globals.dart';

enum Direction { left, right }

class BottleEnemy extends Enemy with HasCollisionDetection, CollisionCallbacks {
  var velocity = Vector2.zero();
  var direction = Direction.right;

  BottleEnemy({
    super.position,
  });
  @override
  Future<void> onLoad() async {
    add(RectangleHitbox()..collisionType = CollisionType.passive);
    return super.onLoad();
  }

  @override
  void loadAllAnimations() {
    idleAnimation = spriteAnimation("Idle", 9, Vector2(18, 25));
    attackAnimation = spriteAnimation("Attack", 11, Vector2(18, 25));
    super.loadAllAnimations();

    animations = {
      EnemyState.idle: idleAnimation,
      EnemyState.attacking: attackAnimation
    };
  }

  @override
  SpriteAnimation spriteAnimation(
      String state, int amount, Vector2 textureSize) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache('Enemies/Water Bottle/$state.png'),
        SpriteAnimationData.sequenced(
            amount: amount,
            stepTime: Globals.animationStepTime,
            textureSize: textureSize));
  }

  @override
  void update(double dt) {
    super.update(dt);
    elapsedTime += dt;

    // Check if it's time to switch states
    if (isAttacking && elapsedTime >= attackTime) {
      switchToIdle();
      _swapDirection();
    } else if (!isAttacking && elapsedTime >= idleTime) {
      switchToAttack();
    }

    // Check if enemy is attacking
    if (isAttacking && elapsedTime <= attackTime) {
      _bottleSpinAttack();
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

  void _bottleSpinAttack() {
    if (direction == Direction.right) {
      super.position += Vector2(.15, 0);
    }
    if (direction == Direction.left) {
      super.position += Vector2(-.15, 0);
    }
  }

  void _swapDirection() {
    direction =
        (direction == Direction.left) ? Direction.right : Direction.left;
    flipHorizontallyAroundCenter();
  }
}
