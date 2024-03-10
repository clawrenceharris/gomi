import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/game/components/entities/enemies/enemy.dart';
import 'package:gomi/game/gomi_level.dart';

abstract class Powerup extends SpriteComponent
    with CollisionCallbacks, HasWorldReference<GomiLevel> {
  Powerup({super.position, super.size});
  late final int coins;
  late final String name;
  late final String description;
  late final String image;

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Enemy) {
      other.removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

  void activate() {
    add(RectangleHitbox(collisionType: CollisionType.active, size: size));
  }
}
