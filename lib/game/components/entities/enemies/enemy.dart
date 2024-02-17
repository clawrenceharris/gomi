import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'dart:async';

import 'package:gomi/game/gomi_game.dart';
import 'package:gomi/game/gomi_level.dart';

enum EnemyState {
  idle,
  attacking,
  hit;
}

abstract class Enemy extends SpriteAnimationGroupComponent
    with HasGameRef<Gomi>, HasWorldReference<GomiLevel>, CollisionCallbacks {
  Enemy({super.position, super.size});
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation attackAnimation;
  double idleTime = 5; // Time to stay in idle state (in seconds)
  double attackTime = 5; // Time to stay in attacking state (in seconds)
  double elapsedTime = 0.0; // Accumulated time for the current state
  bool isAttacking = false;
  late final Vector2 startingPosition;
  bool gotHit = false;
  bool renderFlipX = false;
  @override
  FutureOr<void> onLoad() {
    startingPosition = Vector2(position.x, position.y);
    loadAllAnimations();
    return super.onLoad();
  }

  void respawn() {
    position = Vector2(startingPosition.x, startingPosition.y);
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
    _swapDirection(world.player);
    super.update(dt);
  }

  //returns whether the world.player is above the enemy and stomped on it
  bool isStomped() {
    return world.player.velocity.y > 0 &&
        world.player.y + world.player.height > position.y;
  }

  bool playerIsCorrectColor();

  void attack(double dt);
  void collideWithPlayer() async {
    if (world.player.gotHit) {
      return;
    }
    if (!isAttacking && isStomped() && playerIsCorrectColor()) {
      gotHit = true;
      current = EnemyState.hit;
      world.player.bounce();
      removeFromParent();
    } else if (isAttacking) {
      await world.player.hit();
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

  void _swapDirection(Player other) {
    bool lastState = renderFlipX;

    if (other.x < position.x) {
      renderFlipX = false;
    } else {
      renderFlipX = true;
    }

    if (renderFlipX == lastState) return;
    flipHorizontallyAroundCenter();
  }
}
