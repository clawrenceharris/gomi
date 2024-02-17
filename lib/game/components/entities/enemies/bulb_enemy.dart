import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/game/components/entities/enemies/enemy.dart';
import 'package:gomi/game/components/entities/player.dart';

// class BulbEnemy extends Enemy {
//   final int direction;
//   BulbEnemy({
//     required this.direction,
//     super.position,
//   }) : super(anchor: Anchor.centerRight);
//   double _elapsedTime = 0.0;
//   double zapCoolDown = 3;
//   @override
//   FutureOr<void> onLoad() {
//     super.onLoad();

//     add(RectangleHitbox(collisionType: CollisionType.passive));
//     if (direction > 0) {
//       flipHorizontally();
//     }

//     final moveEffect = MoveEffect.to(
//         Vector2(position.x, position.y + -height / 2 - 10),
//         EffectController(
//           alternate: true,
//           duration:
//               2.0, // Total duration for the up-and-down movement (seconds)
//           infinite: true,
//         ));
//     add(moveEffect);
//     current = EnemyState.attacking;
//   }

//   @override
//   bool isStomped() {
//     return world.player.velocity.y > 0 &&
//         world.player.y + world.player.height > position.y - height / 2;
//   }

//   @override
//   bool playerIsCorrectColor() {
//     return world.player.color == GomiColor.black;
//   }

//   @override
//   void update(double dt) {
//     _attack(dt);
//     super.update(dt);
//   }

//   void _attack(double dt) {
//     _elapsedTime += dt;
//     if (_elapsedTime >= zapCoolDown) {
//       world.add(Zap(
//           position: Vector2(position.x, position.y + height / 2),
//           direction: direction));
//       _elapsedTime = 0.0;
//     }
//   }

//   @override
//   void loadAllAnimations() {
//     idleAnimation = AnimationConfigs.bulbEnemy.idle();
//     attackAnimation = AnimationConfigs.bulbEnemy.attacking();
//     current = EnemyState.attacking;
//     super.loadAllAnimations();
//   }
// }

class BulbEnemy extends Enemy {
  final int direction;
  BulbEnemy({
    required this.direction,
    super.position,
  });
  double _elapsedTime = 0.0; // Accumulated time for the current state
  double zapCoolDown = 3;
  late final SpriteAnimationComponent sparks;
  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(collisionType: CollisionType.passive));

    // sparks = Sparks(position: Vector2(position.x + 10, position.y + 3));
    //world.add(sparks);
    final moveEffect = MoveEffect.to(
        Vector2(position.x, position.y + -10),
        EffectController(
          alternate: true,
          duration:
              2.0, // Total duration for the up-and-down movement (seconds)
          infinite: true,
        ));
    add(moveEffect);
    return super.onLoad();
  }

  @override
  bool playerIsCorrectColor() {
    return world.player.color == GomiColor.black;
  }

  @override
  void onRemove() {
    //sparks.removeFromParent();
    super.onRemove();
  }

  void _attack(double dt) {
    // sparks.position = Vector2(position.x + 8, position.y - 8);
    _elapsedTime += dt;
    if (_elapsedTime >= zapCoolDown) {
      world.add(Zap(
          position: Vector2(position.x, position.y + height / 2),
          direction: direction));
      _elapsedTime = 0.0;
    }
  }

  @override
  void update(double dt) {
    _attack(dt);

    super.update(dt);
  }

  @override
  void loadAllAnimations() {
    idleAnimation = AnimationConfigs.bulbEnemy.idle();
    attackAnimation = AnimationConfigs.bulbEnemy.attacking();
    current = EnemyState.attacking;
    super.loadAllAnimations();
  }
}

class Zap extends SpriteAnimationComponent with CollisionCallbacks {
  final int direction;
  final _speed = 60;
  late final Vector2 startingPosition;
  double elapsedTime = 0.0;
  double activeTime = 9;
  Zap({super.position, super.size, required this.direction})
      : super(animation: AnimationConfigs.bulbEnemy.zap()) {
    startingPosition = Vector2(position.x, position.y);
  }

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.x += direction * _speed * dt;
    if ((position.x - startingPosition.x).abs() >= 5 * Globals.tileSize) {
      removeFromParent();
    }
    super.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      other.hit();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}

// class Sparks extends SpriteAnimationComponent with CollisionCallbacks {
//   Sparks({super.position, super.size})
//       : super(
//             anchor: Anchor.topCenter,
//             animation: AnimationConfigs.bulbEnemy.sparks());

//   @override
//   FutureOr<void> onLoad() {
//     add(CircleHitbox());

//     return super.onLoad();
//   }

//   @override
//   void onCollisionStart(
//       Set<Vector2> intersectionPoints, PositionComponent other) {
//     if (other is Player) {
//       other.hit();
//     }
//     super.onCollisionStart(intersectionPoints, other);
//   }
// }
