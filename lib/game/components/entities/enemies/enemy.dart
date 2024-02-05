import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'dart:async';

import 'package:gomi/game/gomi_game.dart';

enum EnemyState {
  idle,
  attacking,
  hit;
}

abstract class Enemy extends SpriteAnimationGroupComponent
    with HasGameRef<Gomi>, CollisionCallbacks {
  Enemy({super.position, super.size, required this.player});
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation attackAnimation;
  double idleTime = 3; // Time to stay in idle state (in seconds)
  double attackTime = 5; // Time to stay in attacking state (in seconds)
  double elapsedTime = 0.0; // Accumulated time for the current state
  bool isAttacking = false;

  bool isHit = false;
  Player player;
  @override
  FutureOr<void> onLoad() {
    loadAllAnimations();
    add(RectangleHitbox(collisionType: CollisionType.passive));
    return super.onLoad();
  }

  void loadAllAnimations() {
    //list of all animations
    animations = {
      EnemyState.idle: idleAnimation,
      EnemyState.attacking: attackAnimation
    };

    //set current animation
    current = EnemyState.idle;
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
  void update(double dt) {
    elapsedTime += dt;
    // Check if enemy is attacking
    if (isAttacking) {
      attack(dt);
    }
    super.update(dt);
  }

  //returns whether the player is above the enemy and stomped on it
  bool isStomped() {
    return player.velocity.y > 0 && player.y + player.height > position.y;
  }

  bool playerIsCorrectColor();

  void attack(double dt);
  void collideWithPlayer() async {
    if ((isAttacking || !playerIsCorrectColor()) && !player.gotHit) {
      player.collidedWithEnemy();
    } else if (isStomped() && playerIsCorrectColor()) {
      isHit = true;
      current = EnemyState.hit;
      player.bounce();

      await animationTicker?.completed;

      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      collideWithPlayer();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
