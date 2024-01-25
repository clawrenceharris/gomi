import 'package:flame/game.dart';
import 'package:flame/src/sprite_animation.dart';
import 'package:gomi/actors/enemy.dart';
import 'package:gomi/constants/globals.dart';

class SyringeEnemy extends Enemy {
  SyringeEnemy({position}) : super(position: position);

  @override
  SpriteAnimation spriteAnimation(String state) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache('Enemies/Syringe/$state.png'),
        SpriteAnimationData.sequenced(
            amount: 12,
            stepTime: Globals.animationStepTime,
            textureSize: Vector2(51, 22)));
  }
}
