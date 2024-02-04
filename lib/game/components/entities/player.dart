import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/services.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/collision%20blocks/one_way_platform.dart';
import 'package:gomi/game/gomi_game.dart';
import 'package:gomi/game/gomi_world.dart';

enum PlayerState {
  idle,
  walking,
  jumping,
  falling,
  hit,
  disappearing,
  appearing
}

class Player extends SpriteAnimationGroupComponent
    with
        HasGameRef<Gomi>,
        KeyboardHandler,
        CollisionCallbacks,
        HasWorldReference<GomiWorld> {
  Player(
      {required this.color,
      required this.addScore,
      required this.resetScore,
      super.position})
      : super(anchor: Anchor.topCenter) {
    lives = maxLives;
  }

  String color;
  int _jumpCount = 0;
  int maxLives = 1;
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
  int lives = 0;
  double jumpCooldown = 1.5;
  double lastJumpTimestamp = 0.0;
  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;
  bool gotHit = false;
  bool hasHorizontalInput = false;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    debugMode = true;
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
    //TODO: handle collisions with collectables

    super.onCollisionStart(intersectionPoints, other);
  }

  void _loadAllAnimations() {
    SpriteAnimation idleAnimation = AnimationConfigs.gomi.idle(color);
    SpriteAnimation walkingAnimation = AnimationConfigs.gomi.walking(color);
    SpriteAnimation jumpingAnimation = AnimationConfigs.gomi.jumping(color);
    SpriteAnimation disappearingAnimation =
        AnimationConfigs.gomi.disappearing();
    SpriteAnimation appearingAnimation = AnimationConfigs.gomi.appearing();
    SpriteAnimation hitAnimation = AnimationConfigs.gomi.hit(color);

    // List of all animations
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.walking: walkingAnimation,
      PlayerState.jumping: jumpingAnimation,
      PlayerState.disappearing: disappearingAnimation,
      PlayerState.appearing: appearingAnimation,
      PlayerState.hit: hitAnimation
    };

    // Set current animation
    current = PlayerState.idle;
  }

  void collidedWithEnemy() {
    _hit();
  }

  void bounce() {
    game.audioController.playSfx(SfxType.jump);

    velocity.y = -_bounceForce;
  }

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;
    if (velocity.y < 0 && !isGrounded) playerState = PlayerState.jumping;
    if (hasHorizontalInput) playerState = PlayerState.walking;
    if (scale.x < 0 && velocity.x > 0 || scale.x > 0 && velocity.x < 0) {
      flipHorizontallyAroundCenter();
    }

    current = playerState;
  }

  void _respawn() async {
    lives = maxLives;
    scale.x = 1;
    position = startingPosition - Vector2.all(32);
    velocity = Vector2.zero();
    position = startingPosition;
    gotHit = false;
    _updatePlayerState();
  }

  void collidedwithEnemy() {
    _hit();
  }

  void _hit() async {
    gotHit = true;
    current = PlayerState.hit;

    add(OpacityEffect.to(
        0, EffectController(alternate: true, duration: 0.2, repeatCount: 5)));

    await Future.delayed(const Duration(milliseconds: 500));

    if (lives == 0) {
      _respawn();
    } else {
      current = PlayerState.idle;
      gotHit = false;
      lives -= 1;
    }
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

      // Set jump count to 2 to indicate a double jump has been used
      _jumpCount = 2;
    }
  }

  void _applyGravity(double dt) {
    velocity.y += _gravity;
    velocity.y = velocity.y.clamp(-_jumpForce, _maxVelocity);
    position.y += velocity.y * dt;
  }

  void _checkHorizontalCollisions() {
    for (final block in world.collisionBlocks) {
      if (block.blockRect.overlaps(game.camera.visibleWorldRect)) {
        if (block is OneWayPlatform == false) {
          if (world.checkCollisionTopCenter(this, block)) {
            if (velocity.x > 0) {
              velocity.x = 0;
              position.x = block.x - width / 2;
              break;
            }
            if (velocity.x < 0) {
              velocity.x = 0;
              position.x = block.x + block.width + width / 2;
              break;
            }
          }
        }
      }
    }
  }

  void _checkVerticalCollisions() {
    for (final block in world.collisionBlocks) {
      if (block.blockRect.overlaps(game.camera.visibleWorldRect)) {
        if (block is OneWayPlatform) {
          if (world.checkCollisionTopCenter(this, block)) {
            if (velocity.y > 0) {
              velocity.y = 0;
              position.y = block.y - height;
              isGrounded = true;
              break;
            }
          }
        } else {
          if (world.checkCollisionTopCenter(this, block)) {
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
}
