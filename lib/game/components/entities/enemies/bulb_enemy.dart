import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/game/components/entities/enemies/enemy.dart';
import 'package:gomi/game/components/entities/player.dart';

class BulbEnemy extends Enemy {
  int direction;
  BulbEnemy({required this.direction, super.position, super.size});
  double _elapsedTime = 0.0;
  double zapCoolDown = 3;
  late final SpriteAnimationComponent sparks;

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(collisionType: CollisionType.passive));

    return super.onLoad();
  }

  @override
  bool playerIsCorrectColor() {
    return world.player.color == GomiColor.black;
  }

  void _attack(double dt) {
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
    direction = renderFlipX ? 1 : -1;

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
  Zap({super.position, required this.direction})
      : super(
            animation: AnimationConfigs.bulbEnemy.zap(),
            size: Vector2.all(Globals.tileSize)) {
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
    if ((position.x - startingPosition.x).abs() >= 15 * Globals.tileSize) {
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
