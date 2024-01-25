import 'package:flame/components.dart';
import 'package:gomi/actors/enemy.dart';
import 'package:gomi/constants/globals.dart';

class BulbEnemy extends Enemy {
  BulbEnemy({position}) : super(position: position);

  @override
  SpriteAnimation spriteAnimation(String state) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache('Enemies/Light Bulb/$state.png'),
        SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: Globals.animationStepTime,
            textureSize: Vector2(24, 40)));
  }
}
