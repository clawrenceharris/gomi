import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:gomi/constants/globals.dart';

class AnimationConfigs {
  AnimationConfigs._();

  static const String idle = "idle";
  static const String attack = "attack";
  static const String walking = "walk";
  static const String ground = "ground";
  static const String rising = "rising";
  static const String apex = "apex";
  static const String falling = "falling";
  static const String jump = "jump";
  static const String zap = "zap";
  static String sparks = "sparks";

  static const String fall = "fall";
  static const String hit = "hit";
  static const String disappear = "disappear";
  static const String appear = "appear";

  static final Vector2 gomiTextureSize = Vector2(22, 26);
  static final Vector2 zapTextureSize = Vector2(22, 22);

  static final Vector2 bottleEnemyTextureSize = Vector2(16, 25);

  static final Vector2 bulbEnemyTextureSize = Vector2(17, 26);
  static final Vector2 tomatoEnemyTextureSize = Vector2(32, 32);
  static final Vector2 bulbEnemyAttackingTextureSize = Vector2(30, 32);
  static final Vector2 syringeEnemyTextureSize = Vector2(51, 22);
  static final Vector2 seedTextureSize = Vector2(44, 52);

  static const double stepTime = 0.1;

  static const double gomiStepTime = 0.1;
  static const double seedStepTime = 0.2;

  static BottleEnemyAnimationConfigs bottleEnemy =
      BottleEnemyAnimationConfigs();
  static GomiAnimationConfigs gomi = GomiAnimationConfigs();
  static SyringeEnemyAnimationConfigs syringeEnemy =
      SyringeEnemyAnimationConfigs();
  static TomatoEnemyAnimationConfigs tomatoEnemy =
      TomatoEnemyAnimationConfigs();
  static BulbEnemyAnimationConfigs bulbEnemy = BulbEnemyAnimationConfigs();
  static SeedAnimationConfigs seed = SeedAnimationConfigs();
}

class GomiAnimationConfigs {
  SpriteAnimation idle(String color) => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'gomi/${color.toLowerCase()}_gomi/${AnimationConfigs.idle}.png'),
      SpriteAnimationData.sequenced(
          amount: 1,
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
          amount: 4,
          stepTime: AnimationConfigs.gomiStepTime,
          textureSize: AnimationConfigs.gomiTextureSize));
}

class BottleEnemyAnimationConfigs {
  SpriteAnimation idle() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.waterBottle}/${AnimationConfigs.idle}.png'),
      SpriteAnimationData.sequenced(
          amount: 9,
          stepTime: AnimationConfigs.stepTime,
          textureSize: AnimationConfigs.bottleEnemyTextureSize));

  SpriteAnimation attacking() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.waterBottle}/${AnimationConfigs.attack}.png'),
      SpriteAnimationData.sequenced(
          amount: 11,
          stepTime: AnimationConfigs.stepTime,
          textureSize: AnimationConfigs.bottleEnemyTextureSize));
}

class SyringeEnemyAnimationConfigs {
  SpriteAnimation idle() => SpriteAnimation.fromFrameData(
      Flame.images
          .fromCache('enemies/${Globals.syringe}/${AnimationConfigs.idle}.png'),
      SpriteAnimationData.sequenced(
          amount: 12,
          stepTime: AnimationConfigs.stepTime,
          textureSize: AnimationConfigs.syringeEnemyTextureSize));

  SpriteAnimation attacking() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.syringe}/${AnimationConfigs.attack}.png'),
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: AnimationConfigs.stepTime,
          textureSize: AnimationConfigs.syringeEnemyTextureSize));
}

class TomatoEnemyAnimationConfigs {
  SpriteAnimation ground() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.tomato}/${AnimationConfigs.ground}.png'),
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: AnimationConfigs.stepTime,
          textureSize: AnimationConfigs.tomatoEnemyTextureSize));
  SpriteAnimation rising() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.tomato}/${AnimationConfigs.rising}.png'),
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: AnimationConfigs.stepTime,
          textureSize: AnimationConfigs.tomatoEnemyTextureSize));
  SpriteAnimation apex() => SpriteAnimation.fromFrameData(
      Flame.images
          .fromCache('enemies/${Globals.tomato}/${AnimationConfigs.apex}.png'),
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: AnimationConfigs.stepTime,
          textureSize: AnimationConfigs.tomatoEnemyTextureSize));
  SpriteAnimation falling() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.tomato}/${AnimationConfigs.falling}.png'),
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: AnimationConfigs.stepTime,
          textureSize: AnimationConfigs.tomatoEnemyTextureSize));
}

class BulbEnemyAnimationConfigs {
  SpriteAnimation zap() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.lightBulb}/${AnimationConfigs.zap}.png'),
      SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: AnimationConfigs.stepTime,
          textureSize: AnimationConfigs.zapTextureSize));

  SpriteAnimation idle() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.lightBulb}/${AnimationConfigs.idle}.png'),
      SpriteAnimationData.sequenced(
          amount: 13,
          stepTime: AnimationConfigs.stepTime,
          textureSize: AnimationConfigs.bulbEnemyTextureSize));

  SpriteAnimation attacking() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.lightBulb}/${AnimationConfigs.attack}.png'),
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: AnimationConfigs.stepTime,
          textureSize: AnimationConfigs.bulbEnemyTextureSize));

  SpriteAnimation sparks() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.lightBulb}/${AnimationConfigs.sparks}.png'),
      SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: AnimationConfigs.stepTime,
          textureSize: AnimationConfigs.bulbEnemyAttackingTextureSize));
}

class SeedAnimationConfigs {
  SpriteAnimation idle() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache('collectibles/${Globals.seed}/idle.png'),
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: AnimationConfigs.seedStepTime,
          textureSize: AnimationConfigs.seedTextureSize));

  SpriteAnimation growing() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache('collectibles/${Globals.seed}/grow.png'),
      SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: AnimationConfigs.seedStepTime,
          textureSize: AnimationConfigs.seedTextureSize,
          loop: false));
}
