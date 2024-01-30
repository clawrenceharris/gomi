import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:gomi/components/collision%20blocks/collision_block.dart';
import 'package:gomi/components/collision%20blocks/one_way_platform.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/gomi.dart';

enum PlayerState {
  idle,
}

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<Gomi>, KeyboardHandler, CollisionCallbacks {
  String character;
  Player({position, required this.character, required this.collisionBlocks})
      : super(position: position);

  late final SpriteAnimation idleAnimation;

  final double _gravity = 9.8;
  final double _jumpForce = 200;
  final double _maxVelocity = 300;
  bool hasJumped = false;

  double directionX = 0;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();
  bool isGrounded = false;
  List<CollisionBlock> collisionBlocks;

  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;
  final hitbox = RectangleHitbox();
  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    // debugMode = true;

    debugMode = true;
    add(hitbox);
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
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    directionX = 0;
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);

    directionX += isLeftKeyPressed ? -1 : 0;
    directionX += isRightKeyPressed ? 1 : 0;

    hasJumped = keysPressed.contains(LogicalKeyboardKey.space);

    return super.onKeyEvent(event, keysPressed);
  }

  void _loadAllAnimations() {
    idleAnimation = _spriteAnimation('Idle', 13);

    // List of all animations
    animations = {
      PlayerState.idle: idleAnimation,
    };

    // Set current animation
    current = PlayerState.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Main Characters/Green Gomi/$state.png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: Globals.animationStepTime,
        textureSize: Vector2(22, 26),
      ),
    );
  }

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;

    //TODO: Check if moving, set running state

    //TODO: Check if Falling set to falling state

    //TODO: Check if jumping, set to jumping state

    current = playerState;
  }

  void _updatePlayerMovement(double dt) {
    if (hasJumped && isGrounded) _jump(dt);

    velocity.x = directionX * moveSpeed;
    position += velocity * dt;
  }

  void _jump(double dt) {
    velocity.y = -_jumpForce;
    isGrounded = false;
    hasJumped = true;
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
    final playerWidth = width;
    final playerHeight = height;

    final blockX = block.x;
    final blockY = block.y;
    final blockWidth = block.width;
    final blockHeight = block.height;

    final fixedX = playerX;
    final fixedY = block is OneWayPlatform ? playerY + playerHeight : playerY;

    return (fixedY < blockY + blockHeight &&
        playerY + playerHeight > blockY &&
        fixedX < blockX + blockWidth &&
        fixedX + playerWidth > blockX);
  }
}
