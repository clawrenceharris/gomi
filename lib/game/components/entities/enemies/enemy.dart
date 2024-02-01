import 'package:flame/components.dart';
import 'dart:async';

import 'package:gomi/game/gomi_game.dart';

enum EnemyState {
  idle,
  attacking;
}

abstract class Enemy extends SpriteAnimationGroupComponent
    with HasGameRef<Gomi> {
  Enemy({super.position});
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation attackAnimation;
  late double idleTime = 4; // Time to stay in idle state (in seconds)
  late double attackTime = 4; // Time to stay in attacking state (in seconds)
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
      EnemyState.attacking: attackAnimation
    };

    //set current animation
    current = EnemyState.idle;
  }
}
