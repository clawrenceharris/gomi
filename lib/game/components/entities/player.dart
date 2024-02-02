import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/services.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/collision%20blocks/one_way_platform.dart';
import 'package:gomi/game/gomi_game.dart';

enum PlayerState { idle, walking, jumping, falling, hit }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<Gomi>, KeyboardHandler, CollisionCallbacks {
  String character;
  Player(
      {required this.character,
      required this.addScore,
      required this.resetScore,
      super.position});

  int _jumpCount = 0;

  final double _gravity = 9.8;
  final double _jumpForce = 260;
  final double _maxVelocity = 300;
  final double _bounceForce = 200;
  bool hasJumped = false;
  final void Function({int amount}) addScore;
  final VoidCallback resetScore;
  double directionX = 0;
  double moveSpeed = 100;
  Vector2 startingPosition = Vector2.zero();
  Vector2 velocity = Vector2.zero();
  bool isGrounded = false;
  int lives = 2;
  double jumpCooldown = 1.5;
  double lastJumpTimestamp = 0.0;
  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;
  bool gotHit = false;
  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    // debugMode = true;
    startingPosition = Vector2(position.x, position.y);
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    accumulatedTime += dt;
    if (gotHit) {
      return;
    }
    while (accumulatedTime >= fixedDeltaTime) {
      _updatePlayerState();
      _updatePlayerMovement(fixedDeltaTime);
      _checkHorizontalCollisions();
      _applyGravity(fixedDeltaTime);
      _checkVerticalCollisions();

      accumulatedTime -= fixedDeltaTime;
    }

    super.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    //TODO: handle collisions with enemies, collectables, etc

    super.onCollisionStart(intersectionPoints, other);
  }

  void _loadAllAnimations() {
    SpriteAnimation idleAnimation = AnimationConfigs.gomi.idle(character);
    SpriteAnimation walkingAnimation = AnimationConfigs.gomi.walking(character);
    SpriteAnimation jumpingAnimation = AnimationConfigs.gomi.jumping(character);

    // List of all animations
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.walking: walkingAnimation,
      PlayerState.jumping: jumpingAnimation,
    };

    // Set current animation
    current = PlayerState.idle;
  }

  void collidedWithEnemy() {
    _respawn();
  }

  void bounce() {
    game.audioController.playSfx(SfxType.jump);

    velocity.y = -_bounceForce;
  }

  void _respawn() async {
    hit();
    position = startingPosition;
  }

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;
    if (velocity.x != 0 && isGrounded) playerState = PlayerState.walking;
    if (velocity.y < 0 && !isGrounded) playerState = PlayerState.jumping;

    if (scale.x < 0 && velocity.x > 0 || scale.x > 0 && velocity.x < 0) {
      flipHorizontallyAroundCenter();
    }

    current = playerState;
  }

  void hit() {
    add(OpacityEffect.to(
        0, EffectController(alternate: true, duration: 0.2, repeatCount: 5)));
  }

  void _updatePlayerMovement(double dt) {
    if (hasJumped) _jump(dt);

    velocity.x = directionX * moveSpeed;
    position.x += velocity.x * dt;
  }

  void _jump(double dt) {
    hasJumped = false;

    if (isGrounded) {
      // Player is grounded, perform a regular jump
      velocity.y = -_jumpForce;
      position.y += velocity.y * dt;
      _jumpCount = 1;
      game.audioController.playSfx(SfxType.jump);

      isGrounded = false;
    } else if (_jumpCount < 2) {
      // Perform a double jump
      game.audioController.playSfx(SfxType.doubleJump);

      velocity.y = -_jumpForce;
      position.y += velocity.y * dt;

      _jumpCount =
          2; // Set jump count to 2 to indicate a double jump has been used
    }
  }

  void _applyGravity(double dt) {
    velocity.y += _gravity;
    velocity.y = velocity.y.clamp(-_jumpForce, _maxVelocity);
    position.y += velocity.y * dt;
  }

  void _checkHorizontalCollisions() {
    for (final block in game.world.collisionBlocks) {
      if (block is OneWayPlatform == false) {
        if (game.world.checkCollision(block, this)) {
          if (velocity.x > 0) {
            velocity.x = 0;
            position.x = block.x - width;
            break;
          }
          if (velocity.x < 0) {
            velocity.x = 0;
            position.x = block.x + block.width;
            break;
          }
        }
      }
    }
  }

  void _checkVerticalCollisions() {
    for (final block in game.world.collisionBlocks) {
      if (block is OneWayPlatform) {
        if (game.world.checkCollision(block, this)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - height;
            isGrounded = true;
            break;
          }
        }
      } else {
        if (game.world.checkCollision(block, this)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - height;
            isGrounded = true;
            break;
          }
          if (velocity.y < 0) {
            velocity.y = 0;
            position.y = block.y + block.height;
          }
        }
      }
    }
  }
}
