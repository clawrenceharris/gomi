import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:gomi/game/components/entities/enemies/enemy.dart';
import 'package:gomi/game/components/entities/physics_entity.dart';
import 'package:gomi/game/gomi_level.dart';

abstract class Powerup extends SpriteComponent
    with CollisionCallbacks, PhysicsEntity, HasWorldReference<GomiLevel> {
  Powerup({super.position, super.size});
  late final int coins;
  late final String name;
  late final String description;
  late final String image;
  final RectangleHitbox hitbox = RectangleHitbox();
  late final double duration;
  double elapsedTime = 0.0;

  @override
  FutureOr<void> onLoad() async {
    var image = await Flame.images.load(this.image);
    sprite = Sprite(image);
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Enemy) {
      handleEnemyCollision(other);
    }
    super.onCollision(intersectionPoints, other);
  }

  void handleEnemyCollision(PositionComponent other) {
    other.removeFromParent();
  }

  @override
  void update(double dt) {
    elapsedTime += dt;
    if (elapsedTime >= duration) {
      elapsedTime = 0.0;
      removeFromParent();
    }
    super.update(dt);
  }

  void activate() {
    add(RectangleHitbox(collisionType: CollisionType.active, size: size));
  }
}
