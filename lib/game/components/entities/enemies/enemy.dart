import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/game/components/entities/gomi_entity.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'dart:async';

import 'package:gomi/game/gomi_game.dart';

abstract class Enemy extends GomiEntity
    with HasGameRef<Gomi>, CollisionCallbacks {
  Enemy({super.position, super.size, super.anchor}) {
    initialPosition = Vector2(position.x, position.y);
  }
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation attackAnimation;
  double idleTime = 5; // Time to stay in idle state (in seconds)
  double attackTime = 5; // Time to stay in attacking state (in seconds)
  double elapsedTime = 0.0; // Accumulated time for the current state
  bool isAttacking = false;
  bool renderFlipX = false;
  int points = 100;

  @override
  FutureOr<void> onLoad() {
    loadAllAnimations();
    return super.onLoad();
  }

  void respawn() {
    current = GomiEntityState.attacking;
    position = Vector2(initialPosition.x, initialPosition.y);
  }

  void loadAllAnimations() {
    //list of all animations
    animations = {
      GomiEntityState.idle: idleAnimation,
      GomiEntityState.attacking: attackAnimation
    };
  }

  @override
  void update(double dt) {
    swapDirection(world.player);
    super.update(dt);
  }

  //returns whether the world.player is above the enemy and stomped on it
  bool isStomped() {
    return world.player.velocity.y > 0 &&
        world.player.y + world.player.height > position.y;
  }

  bool playerIsCorrectColor();
  void hit() {
    gotHit = true;
    current = GomiEntityState.hit;
    world.player.bounce();
    world.player.playerScore.addScore(points);
    playHitSfx();

    removeFromParent();
  }

  void collideWithPlayer() async {
    if (isStomped() && playerIsCorrectColor()) {
      hit();
    } else {
      world.player.hit();
    }
  }

  void playHitSfx();

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      collideWithPlayer();
    }
    super.onCollision(intersectionPoints, other);
  }

  void swapDirection(Player other) {
    bool lastState = renderFlipX;

    if (other.x < position.x) {
      renderFlipX = false;
    } else if (other.x >= position.x && other.x <= position.x + width) {
      // do not flip
      return;
    } else {
      renderFlipX = true;
    }

    if (renderFlipX == lastState) return;
    flipHorizontallyAroundCenter();
  }
}
