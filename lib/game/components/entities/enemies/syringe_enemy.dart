import 'dart:async';

import 'package:flame/components.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/game/components/entities/enemies/enemy.dart';

class SyringeEnemy extends Enemy {
  final double offNeg;
  final double offPos;

  SyringeEnemy({super.position, this.offNeg = 0, this.offPos = 0});

  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    return super.onLoad();
  }

  @override
  void loadAllAnimations() {
    idleAnimation = spriteAnimation("Idle", 12, Vector2(51, 22));
    super.loadAllAnimations();
  }

  @override
  SpriteAnimation spriteAnimation(
      String state, int amount, Vector2 textureSize) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache('Enemies/Syringe/$state.png'),
        SpriteAnimationData.sequenced(
            amount: amount,
            stepTime: Globals.animationStepTime,
            textureSize: textureSize));
  }
}
