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

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }

  void _loadAllAnimations() {
    idleAnimation = spriteAnimation("Idle");
    //list of all animations
    animations = {EnemyState.idle: idleAnimation};

    //set current animation
    current = EnemyState.idle;
  }

  SpriteAnimation spriteAnimation(String state);
}
