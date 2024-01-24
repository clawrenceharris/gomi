import 'package:flame/components.dart';
import 'dart:async';

import 'package:gomi/gomi.dart';

enum EnemyState { idle, attacking }

class Enemy extends SpriteAnimationGroupComponent with HasGameRef<Gomi> {
  Enemy({position}) : super(position: position);
  late final SpriteAnimation idleAnimation;
  final double stepTime = 0.05;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }

  void _loadAllAnimations() {
    idleAnimation = SpriteAnimation.fromFrameData(
        game.images.fromCache('light-bulb.png'),
        SpriteAnimationData.sequenced(
            amount: 1, stepTime: stepTime, textureSize: Vector2(24, 40)));
    //list of all animations
    animations = {EnemyState.idle: idleAnimation};

    //set current animation
    current = EnemyState.idle;
  }
}
