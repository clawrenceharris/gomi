import 'dart:async';

import 'package:flame/components.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/gomi.dart';

enum PlayerState {
  idle,
  running,
}

class Player extends SpriteAnimationGroupComponent<PlayerState>
    with HasGameRef<Gomi> {
  late final SpriteAnimation idleAnimation;
  Player({position, required this.character}) : super(position: position);
  String character;

  @override
  FutureOr<void> onLoad() {
    _loadAnimation();
    return super.onLoad();
  }

  void _loadAnimation() {
    idleAnimation = _spriteAnimation("Idle", 7);

    //List of all animations
    animations = {
      PlayerState.idle: idleAnimation,
    };

    //Set current animation
    current = PlayerState.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
        gameRef.images.fromCache('Main Characters/$character/$state.png'),
        SpriteAnimationData.sequenced(
          amount: amount,
          stepTime: Globals.animationStepTime,
          textureSize: Vector2(22, 26),
        ));
  }
}
