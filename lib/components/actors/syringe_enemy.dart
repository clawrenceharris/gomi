import 'package:flame/game.dart';
import 'package:flame/src/sprite_animation.dart';
import 'package:gomi/actors/enemy.dart';
import 'package:gomi/constants/globals.dart';

class SyringeEnemy extends Enemy {
  SyringeEnemy({position}) : super(position: position);
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
