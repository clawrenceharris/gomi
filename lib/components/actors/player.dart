import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:gomi/components/actors/seed.dart';
import 'package:gomi/components/collision%20blocks/collision_block.dart';
import 'package:gomi/components/collision%20blocks/one_way_platform.dart';
import 'package:gomi/components/collisions/custom_hitbox.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/gomi.dart';

enum PlayerState {
  idle,
}

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<Gomi>, KeyboardHandler, CollisionCallbacks {
  String character;
  Player({
    position,
    required this.collisionBlocks,
    this.character = 'Green Gomi',
  }) : super(position: position);

  late final SpriteAnimation idleAnimation;

  final double _gravity = 9.8;
  final double _jumpForce = 300;
  final double _terminalVelocity = 300;
  bool hasJumped = false;

  double directionX = 0;
  double moveSpeed = 100;
  Vector2 startingPosition = Vector2.zero();
  Vector2 velocity = Vector2.zero();
  bool isGrounded = false;
  bool reachedCheckpoint = false;
  List<CollisionBlock> collisionBlocks;
  CustomHitbox hitbox = CustomHitbox(
    offsetX: 10,
    offsetY: 0,
    width: 14,
    height: 28,
  );
  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();

    startingPosition = Vector2(position.x, position.y);

    add(RectangleHitbox(
      position: Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height),
    ));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    accumulatedTime += dt;

    while (accumulatedTime >= fixedDeltaTime) {
      _updatePlayerState();
      _updatePlayerMovement(fixedDeltaTime);
      _applyGravity(fixedDeltaTime);
      _checkCollisions();

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

    hasJumped = keysPressed.contains(LogicalKeyboardKey.space) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp);

    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    //TODO: handle collisions with enemies, collectables, etc
    if (other is Seed) {
      other.collidedWithPlayer();
    }
    super.onCollisionStart(intersectionPoints, other);
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

    if (velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }

    //TODO: Check if moving, set running

    //TODO: Check if Falling set to falling

    //TODO: Check if jumping, set to jumping

    current = playerState;
  }

  void _updatePlayerMovement(double dt) {
    if (hasJumped && isGrounded) _jump(dt);

    // if (velocity.y > _gravity) isOnGround = false; // optional

    velocity.x = directionX * moveSpeed;
    position.x += velocity.x * dt;
  }

  void _jump(double dt) {
    velocity.y = -_jumpForce;
    position.y += velocity.y * dt;
    isGrounded = false;
    hasJumped = false;
  }

  void _applyGravity(double dt) {
    velocity.y += _gravity;
    velocity.y = velocity.y.clamp(-_jumpForce, _terminalVelocity);
    position.y += velocity.y * dt;
  }

  void _checkCollisions() {
    for (final block in collisionBlocks) {
      if (_checkCollision(block)) {
        block.onPlayerCollision(this);
      }
    }
  }

  bool _checkCollision(CollisionBlock block) {
    final playerX = position.x + hitbox.offsetX;
    final playerY = position.y + hitbox.offsetY;
    final playerWidth = hitbox.width;
    final playerHeight = hitbox.height;

    final blockX = block.x;
    final blockY = block.y;
    final blockWidth = block.width;
    final blockHeight = block.height;

    final fixedX =
        scale.x < 0 ? playerX - (hitbox.offsetX * 2) - playerWidth : playerX;
    final fixedY = block is OneWayPlatform ? playerY + playerHeight : playerY;

    return (fixedY < blockY + blockHeight &&
        playerY + playerHeight > blockY &&
        fixedX < blockX + blockWidth &&
        fixedX + playerWidth > blockX);
  }
}
