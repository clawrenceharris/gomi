import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gomi/game/components/collision%20blocks/collision_block.dart';
import 'package:gomi/game/components/collision%20blocks/one_way_platform.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/game/gomi_game.dart';

enum PlayerState {
  idle,
}

mixin HasPlayerRef {
  late final Player player;
  setPlayer(Player player) {
    this.player = player;
  }
}

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<Gomi>, CollisionCallbacks {
  String character;
  Player({
    position,
    required this.character,
    required this.collisionBlocks,
    required this.addScore,
    required this.resetScore,
  }) : super(position: position);

  final double stepTime = 0.05;
  late final SpriteAnimation idleAnimation;

  final void Function({int amount}) addScore;
  final VoidCallback resetScore;
  final double _gravity = 9.8;
  final double _jumpForce = 200;
  final double _maxVelocity = 300;
  bool hasJumped = false;
  double directionX = 0;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();
  bool isGrounded = false;
  final List<CollisionBlock> collisionBlocks;

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
      _updateVelocityX(fixedDeltaTime);
      _checkHorizontalCollisions();
      _updateVelocityY(fixedDeltaTime);
      _checkVerticalCollisions();
      _updateJump(fixedDeltaTime);
      _updatePlayerPosition(fixedDeltaTime);

      accumulatedTime -= fixedDeltaTime;
    }

    super.update(dt);
  }

  void _updatePlayerPosition(double dt) {
    position += velocity * dt;
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
      game.images.fromCache('gomi/$character/$state.png'),
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

  void _updateJump(double dt) {
    if (hasJumped && isGrounded) jump(dt);
  }

  void _updateVelocityX(double dt) {
    velocity.x = directionX * moveSpeed;
  }

  void jump(double dt) {
    velocity.y = -_jumpForce;
    isGrounded = false;
    hasJumped = true;
  }

  void _updateVelocityY(double dt) {
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
            position.x = block.x - hitbox.width;
            break;
          }
          if (velocity.x < 0) {
            velocity.x = 0;
            position.x = block.x + block.width + hitbox.width;
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
            position.y = block.y - hitbox.height;
            isGrounded = true;
            break;
          }
        }
      } else {
        if (_checkCollision(block)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - hitbox.height;
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
