import 'package:flame/components.dart';
import 'dart:async';

import 'package:gomi/gomi.dart';

enum EnemyState {
  idle,
  attacking;
}

abstract class Enemy extends SpriteAnimationGroupComponent
    with HasGameRef<Gomi> {
  Enemy({position}) : super(position: position);
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation attackAnimation;
  late double idleTime = 4; // Time to stay in idle state (in seconds)
  late double attackTime = 5; // Time to stay in attacking state (in seconds)
  late double elapsedTime = 0.0; // Accumulated time for the current state
  late bool isAttacking = false; // Flag to track the current state

  @override
  FutureOr<void> onLoad() {
    loadAllAnimations();
    return super.onLoad();
  }

  void loadAllAnimations() {
    //list of all animations
    animations = {
      EnemyState.idle: idleAnimation,
    };

    //set current animation
    current = EnemyState.idle;
  }

  SpriteAnimation spriteAnimation(
      String state, int amount, Vector2 textureSize);
}
