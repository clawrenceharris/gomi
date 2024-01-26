import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/gomi.dart';

enum PlayerState {
  idle,
  running,
}

class Player extends SpriteAnimationGroupComponent<PlayerState>
    with HasGameRef<Gomi>, KeyboardHandler {
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  Player({position, required this.character}) : super(position: position);
  String character;
  Vector2 velocity = Vector2.zero();
  double moveSpeed = 100;
  Vector2 direction = Vector2.zero();
  final double _gravity = 9.8;
  final double _jumpForce = 300;
  final double maxVelocity = 300;
  bool isOnGround = false;
  bool hasJumped = false;

  @override
  FutureOr<void> onLoad() {
    _loadAnimation();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerX(dt);
    _updatePlayerState();
    _applyGravity(dt);
    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    direction.x = 0;
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);

    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);

    direction.x += isLeftKeyPressed ? -1 : 0;
    direction.x += isRightKeyPressed ? 1 : 0;

    hasJumped = keysPressed.contains(LogicalKeyboardKey.space);

    return super.onKeyEvent(event, keysPressed);
  }

  void _updatePlayerX(dt) {
    if (hasJumped && isOnGround) _jump(dt);
    if (velocity.y > _gravity) isOnGround = false;

    velocity.x = direction.x * moveSpeed;
    position.x += velocity.x * dt;
  }

  void _jump(double dt) {
    velocity.y = -_jumpForce;
    position.y += velocity.y * dt;
    isOnGround = false;
    hasJumped = false;
  }

  void _loadAnimation() {
    idleAnimation = _spriteAnimation("Idle", 13, Vector2(22, 26));
    runningAnimation = _spriteAnimation("Run", 3, Vector2(22, 26));

    //List of all animations
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
    };

    //Set current animation
    current = PlayerState.idle;
  }

  SpriteAnimation _spriteAnimation(
      String state, int amount, Vector2 textureSize) {
    return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('Main Characters/Blue Gomi/$state.png'),
        SpriteAnimationData.sequenced(
          amount: amount,
          stepTime: Globals.animationStepTime,
          textureSize: textureSize,
        ));
  }

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;

    //flip sprite based on direction
    if (velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }

    //Check if moving, set running
    if (velocity.x != 0) {
      playerState = PlayerState.running;
    }
    current = playerState;
  }

  void _applyGravity(double dt) {
    velocity.y += _gravity;
    velocity.y = velocity.y.clamp(-_jumpForce, maxVelocity);
    position.y += velocity.y * dt;
  }
}
