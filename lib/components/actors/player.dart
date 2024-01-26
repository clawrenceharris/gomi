import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/gomi.dart';

enum PlayerState {
  idle,
  running,
}

enum PlayerDirection { left, right, idle }

class Player extends SpriteAnimationGroupComponent<PlayerState>
    with HasGameRef<Gomi>, KeyboardHandler {
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;

  Player({position, required this.character}) : super(position: position);
  String character;
  Vector2 velocity = Vector2.zero();
  double moveSpeed = 100;
  Vector2 direction = Vector2.zero();

  @override
  FutureOr<void> onLoad() {
    _loadAnimation();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerX(dt);
    _updatePlayerState();

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

    return super.onKeyEvent(event, keysPressed);
  }

  void _updatePlayerX(dt) {
    velocity.x = direction.x * moveSpeed;
    position.x += velocity.x * dt;
  }

  void jump() {
    position.y -= 50; // Jump height
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
}
