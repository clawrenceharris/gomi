import 'package:flame/components.dart';
import 'package:gomi/components/actors/enemy.dart';
import 'package:gomi/constants/globals.dart';

class BulbEnemy extends Enemy {
  BulbEnemy({position}) : super(position: position);

  @override
  void loadAllAnimations() {
    idleAnimation = spriteAnimation("Idle", 10, Vector2(17, 32));
    super.loadAllAnimations();
  }

  @override
  SpriteAnimation spriteAnimation(
      String state, int amount, Vector2 textureSize) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache('Enemies/Light Bulb/$state.png'),
        SpriteAnimationData.sequenced(
            amount: amount,
            stepTime: Globals.animationStepTime,
            textureSize: textureSize));
  }
}
