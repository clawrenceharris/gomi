import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/collision%20blocks/collision_block.dart';
import 'package:gomi/game/components/collision%20blocks/one_way_platform.dart';
import 'package:gomi/game/gomi_game.dart';

enum PlayerState {
  idle,
  walkingLeft,
  walkingRight,
  jumping,
  falling,
}

mixin HasPlayerRef {
  late final Player player;
  setPlayer(Player player) {
    this.player = player;
  }
}

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<Gomi>, KeyboardHandler, CollisionCallbacks {
  String character;
  Player(
      {required this.character,
      required this.collisionBlocks,
      required this.addScore,
      required this.resetScore,
      super.position});

  int _jumpCount = 0;

  final double _gravity = 9.8;
  final double _jumpForce = 260;
  final double _maxVelocity = 300;
  bool hasJumped = false;

  final void Function({int amount}) addScore;
  final VoidCallback resetScore;
  double directionX = 0;
  double moveSpeed = 100;
  Vector2 startingPosition = Vector2.zero();
  Vector2 velocity = Vector2.zero();
  bool isGrounded = false;
  List<CollisionBlock> collisionBlocks;
  double jumpCooldown = 1.0; // Set the desired cooldown time in seconds
  double lastJumpTimestamp = 0.0;
  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;
  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    // debugMode = true;

    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    accumulatedTime += dt;

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
    SpriteAnimation walkingRightAnimation =
        AnimationConfigs.gomi.walkingRight(character);
    SpriteAnimation walkingLeftAnimation =
        AnimationConfigs.gomi.walkingLeft(character);
    SpriteAnimation jumpingAnimation = AnimationConfigs.gomi.jumping(character);

    // List of all animations
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.walkingRight: walkingRightAnimation,
      PlayerState.walkingLeft: walkingLeftAnimation,
      PlayerState.jumping: jumpingAnimation,
    };

    // Set current animation
    current = PlayerState.idle;
  }

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;

    //TODO: Check if moving, set running

    //TODO: Check if Falling set to falling

    //TODO: Check if jumping, set to jumping

    current = playerState;
  }

  void _updatePlayerMovement(double dt) {
    if (hasJumped) _jump(dt);

    velocity.x = directionX * moveSpeed;
    position.x += velocity.x * dt;
  }

  void _jump(double dt) {
    hasJumped = false;
    final currentTime =
        DateTime.now().millisecondsSinceEpoch / 1000; // Convert to seconds
    if (currentTime - lastJumpTimestamp >= jumpCooldown && isGrounded) {
      // Player is grounded, perform a regular jump
      velocity.y = -_jumpForce;
      position.y += velocity.y * dt;
      _jumpCount = 1;
      isGrounded = false;
    } else if (_jumpCount < 2) {
      // Perform a double jump
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
    for (final block in collisionBlocks) {
      if (block is OneWayPlatform == false) {
        if (_checkCollision(block)) {
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
    for (final block in collisionBlocks) {
      if (block is OneWayPlatform) {
        if (_checkCollision(block)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - height;
            isGrounded = true;
            break;
          }
        }
      } else {
        if (_checkCollision(block)) {
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

  bool _checkCollision(CollisionBlock block) {
    final playerX = position.x;
    final playerY = position.y;

    final blockX = block.x;
    final blockY = block.y;
    final blockWidth = block.width;
    final blockHeight = block.height;

    final fixedY = block is OneWayPlatform ? playerY + height : playerY;

    return (fixedY < blockY + blockHeight &&
        playerY + height > blockY &&
        playerX < blockX + blockWidth &&
        playerX + width > blockX);
  }
}
