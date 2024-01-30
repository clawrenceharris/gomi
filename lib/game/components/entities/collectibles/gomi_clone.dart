import 'dart:async';

import 'package:flame/components.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/game/gomi_game.dart';

enum PlayerState {
  idle,
  running,
}

class GomiClone extends SpriteAnimationComponent with HasGameRef<Gomi> {
  late final SpriteAnimation idleAnimation;

  GomiClone({position, required this.character}) : super(position: position);
  String character;

  @override
  FutureOr<void> onLoad() {
    _loadAnimation();
    return super.onLoad();
  }

  void _loadAnimation() {
    idleAnimation = _spriteAnimation("Idle", 13);
    animation = idleAnimation;
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
