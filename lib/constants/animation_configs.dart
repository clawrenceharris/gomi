import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:gomi/constants/globals.dart';

class AnimationConfigs {
  AnimationConfigs._();

  static const String idle = "idle";
  static const String attack = "attack";
  static const String walkLeft = "walk_left";
  static const String walkRight = "walk_right";
  static const String jump = "jump";
  static const String fall = "fall";
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
  SpriteAnimation idle(String character) => SpriteAnimation.fromFrameData(
      Flame.images.fromCache('gomi/blue_gomi/${AnimationConfigs.idle}.png'),
      SpriteAnimationData.sequenced(
          amount: 13,
          stepTime: AnimationConfigs.gomiStepTime,
          textureSize: Vector2(22, 26)));

  SpriteAnimation walkingLeft(String character) =>
      SpriteAnimation.fromFrameData(
          Flame.images
              .fromCache('gomi/$character/${AnimationConfigs.walkLeft}.png'),
          SpriteAnimationData.sequenced(
              amount: 1,
              stepTime: AnimationConfigs.gomiStepTime,
              textureSize: Vector2(22, 26)));

  SpriteAnimation walking(String character) => SpriteAnimation.fromFrameData(
      Flame.images
          .fromCache('gomi/$character/${AnimationConfigs.walkRight}.png'),
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: AnimationConfigs.gomiStepTime,
          textureSize: Vector2(22, 26)));

  SpriteAnimation jumping(String character) => SpriteAnimation.fromFrameData(
      Flame.images.fromCache('gomi/$character/${AnimationConfigs.jump}.png'),
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: AnimationConfigs.gomiStepTime,
          textureSize: Vector2(22, 26)));

  SpriteAnimation falling(String character) => SpriteAnimation.fromFrameData(
      Flame.images.fromCache('gomi/$character/${AnimationConfigs.fall}.png'),
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: AnimationConfigs.gomiStepTime,
          textureSize: Vector2(22, 26)));
}

class BottleEnemyAnimationConfigs {
  SpriteAnimation idle() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.waterBottle}/${AnimationConfigs.idle}.png'),
      SpriteAnimationData.sequenced(
          amount: 9,
          stepTime: AnimationConfigs.bottleEnemyStepTime,
          textureSize: Vector2(18, 25)));

  SpriteAnimation attacking() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.waterBottle}/${AnimationConfigs.attack}.png'),
      SpriteAnimationData.sequenced(
          amount: 11,
          stepTime: AnimationConfigs.bottleEnemyStepTime,
          textureSize: Vector2(18, 25)));
}

class SyringeEnemyAnimationConfigs {
  SpriteAnimation idle() => SpriteAnimation.fromFrameData(
      Flame.images
          .fromCache('enemies/${Globals.syringe}/${AnimationConfigs.idle}.png'),
      SpriteAnimationData.sequenced(
          amount: 12,
          stepTime: AnimationConfigs.bottleEnemyStepTime,
          textureSize: Vector2(51, 22)));

  SpriteAnimation attacking() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.syringe}/${AnimationConfigs.attack}.png'),
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: AnimationConfigs.bottleEnemyStepTime,
          textureSize: Vector2(51, 22)));
}

class TomatoEnemyAnimationConfigs {
  SpriteAnimation idle() => SpriteAnimation.fromFrameData(
      Flame.images
          .fromCache('enemies/${Globals.tomato}/${AnimationConfigs.idle}.png'),
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: AnimationConfigs.bottleEnemyStepTime,
          textureSize: Vector2(26, 34)));

  SpriteAnimation attacking() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.tomato}/${AnimationConfigs.attack}.png'),
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: AnimationConfigs.bottleEnemyStepTime,
          textureSize: Vector2(26, 34)));
}

class BulbEnemyAnimationConfigs {
  SpriteAnimation idle() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.lightBulb}/${AnimationConfigs.idle}.png'),
      SpriteAnimationData.sequenced(
          amount: 10,
          stepTime: AnimationConfigs.bottleEnemyStepTime,
          textureSize: Vector2(17, 32)));

  SpriteAnimation attacking() => SpriteAnimation.fromFrameData(
      Flame.images.fromCache(
          'enemies/${Globals.lightBulb}/${AnimationConfigs.attack}.png'),
      SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: AnimationConfigs.bottleEnemyStepTime,
          textureSize: Vector2(17, 32)));
}
