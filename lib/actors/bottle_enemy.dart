import 'package:flame/components.dart';
import 'package:gomi/actors/enemy.dart';
import 'package:gomi/constants/globals.dart';

class BottleEnemy extends Enemy {
  BottleEnemy({position}) : super(position: position);

  @override
  SpriteAnimation spriteAnimation(String state) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache('Enemies/Water Bottle/$state.png'),
        SpriteAnimationData.sequenced(
            amount: 11,
            stepTime: Globals.animationStepTime,
            textureSize: Vector2(22, 26)));
  }
}
