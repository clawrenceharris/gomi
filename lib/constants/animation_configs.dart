import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:gomi/constants/globals.dart';

class AnimationConfigs {
  AnimationConfigs._();

  static const String idle = "idle";
  static const String attack = "attack";
  static const String walking = "walk";
  static const String jump = "jump";
  static const String zap = "zap";
  static String sparks = "sparks";

  static const String fall = "fall";
  static const String hit = "hit";
  static const String disappear = "disappear";
  static const String appear = "appear";

  static final Vector2 gomiTextureSize = Vector2(22, 26);
  static final Vector2 zapTextureSize = Vector2(22, 16);

  static final Vector2 bottleEnemyTextureSize = Vector2(18, 25);
  static final Vector2 bulbEnemyTextureSize = Vector2(17, 32);
  static final Vector2 tomatoEnemyTextureSize = Vector2(32, 32);
  static final Vector2 bulbEnemyAttackingTextureSize = Vector2(30, 32);
  static final Vector2 syringeEnemyTextureSize = Vector2(51, 22);

  static const double bottleEnemyStepTime = 0.1;
  static const double gomiStepTime = 0.1;

  static BottleEnemyAnimationConfigs bottleEnemy =
      BottleEnemyAnimationConfigs();
  static GomiAnimationConfigs gomi = GomiAnimationConfigs();
  static SyringeEnemyAnimationConfigs syringeEnemy =
      SyringeEnemyAnimationConfigs();
  static TomatoEnemyAnimationConfigs tomatoEnemy =
      TomatoEnemyAnimationConfigs();
  static BulbEnemyAnimationConfigs bulbEnemy = BulbEnemyAnimationConfigs();
}

class GomiAnimationConfigs {
  SpriteAnimation idle(String color) => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'gomi/${color.toLowerCase()}_gomi/${AnimationConfigs.idle}.png'),
      SpriteAnimationData.sequenced(
          amount: 13,
          stepTime: AnimationConfigs.gomiStepTime,
          textureSize: AnimationConfigs.gomiTextureSize));

  SpriteAnimation walking(String color) => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'gomi/${color.toLowerCase()}_gomi/${AnimationConfigs.walking}.png'),
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: AnimationConfigs.gomiStepTime,
          textureSize: AnimationConfigs.gomiTextureSize));

  SpriteAnimation jumping(String color) => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'gomi/${color.toLowerCase()}_gomi/${AnimationConfigs.jump}.png'),
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: AnimationConfigs.gomiStepTime,
          textureSize: AnimationConfigs.gomiTextureSize));

  SpriteAnimation falling(String color) => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'gomi/${color.toLowerCase()}_gomi/${AnimationConfigs.fall}.png'),
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: AnimationConfigs.gomiStepTime,
          textureSize: AnimationConfigs.gomiTextureSize));
  SpriteAnimation disappearing() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache('gomi/${AnimationConfigs.disappear}.png'),
      SpriteAnimationData.sequenced(
          amount: 7,
          loop: false,
          stepTime: 0.05,
          textureSize: Vector2(96, 96)));
  SpriteAnimation appearing() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache('gomi/${AnimationConfigs.appear}.png'),
      SpriteAnimationData.sequenced(
          amount: 7,
          loop: false,
          stepTime: 0.05,
          textureSize: Vector2(96, 96)));
  SpriteAnimation hit(String color) => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'gomi/${color.toLowerCase()}_gomi/${AnimationConfigs.hit}.png'),
      SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: AnimationConfigs.gomiStepTime,
          textureSize: AnimationConfigs.gomiTextureSize));
}

class BottleEnemyAnimationConfigs {
  SpriteAnimation idle() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.waterBottle}/${AnimationConfigs.idle}.png'),
      SpriteAnimationData.sequenced(
          amount: 9,
          stepTime: AnimationConfigs.bottleEnemyStepTime,
          textureSize: AnimationConfigs.bottleEnemyTextureSize));

  SpriteAnimation attacking() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.waterBottle}/${AnimationConfigs.attack}.png'),
      SpriteAnimationData.sequenced(
          amount: 11,
          stepTime: AnimationConfigs.bottleEnemyStepTime,
          textureSize: AnimationConfigs.bottleEnemyTextureSize));
}

class SyringeEnemyAnimationConfigs {
  SpriteAnimation idle() => SpriteAnimation.fromFrameData(
      Flame.images
          .fromCache('enemies/${Globals.syringe}/${AnimationConfigs.idle}.png'),
      SpriteAnimationData.sequenced(
          amount: 12,
          stepTime: AnimationConfigs.bottleEnemyStepTime,
          textureSize: AnimationConfigs.syringeEnemyTextureSize));

  SpriteAnimation attacking() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.syringe}/${AnimationConfigs.attack}.png'),
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: AnimationConfigs.bottleEnemyStepTime,
          textureSize: AnimationConfigs.syringeEnemyTextureSize));
}

class TomatoEnemyAnimationConfigs {
  SpriteAnimation idle() => SpriteAnimation.fromFrameData(
      Flame.images
          .fromCache('enemies/${Globals.tomato}/${AnimationConfigs.idle}.png'),
      SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: AnimationConfigs.bottleEnemyStepTime,
          textureSize: AnimationConfigs.tomatoEnemyTextureSize));

  SpriteAnimation attacking() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.tomato}/${AnimationConfigs.attack}.png'),
      SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: AnimationConfigs.bottleEnemyStepTime,
          textureSize: AnimationConfigs.tomatoEnemyTextureSize));
}

class BulbEnemyAnimationConfigs {
  SpriteAnimation zap() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.lightBulb}/${AnimationConfigs.zap}.png'),
      SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: AnimationConfigs.bottleEnemyStepTime,
          textureSize: AnimationConfigs.zapTextureSize));

  SpriteAnimation idle() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.lightBulb}/${AnimationConfigs.idle}.png'),
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: AnimationConfigs.bottleEnemyStepTime,
          textureSize: AnimationConfigs.bulbEnemyTextureSize));

  SpriteAnimation attacking() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.lightBulb}/${AnimationConfigs.attack}.png'),
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: AnimationConfigs.bottleEnemyStepTime,
          textureSize: AnimationConfigs.bulbEnemyAttackingTextureSize));

  SpriteAnimation sparks() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.lightBulb}/${AnimationConfigs.sparks}.png'),
      SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: AnimationConfigs.bottleEnemyStepTime,
          textureSize: AnimationConfigs.bulbEnemyAttackingTextureSize));
}
