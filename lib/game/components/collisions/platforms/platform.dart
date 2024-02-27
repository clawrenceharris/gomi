import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/game/components/entities/player.dart';

class Platform extends PositionComponent with CollisionCallbacks {
  Platform({super.position, super.size}) : super(anchor: Anchor.topLeft) {
    add(RectangleHitbox());
    debugMode = true;
  }

  bool fromLeft(PositionComponent platform, Player other) {
    return other.velocity.x > 0 &&
        (other.position.x + other.width - platform.position.x).toInt() <= 1;
  }

  bool fromRight(PositionComponent platform, Player other) {
    return other.velocity.x < 0 &&
        (platform.position.x + platform.width - other.position.x).toInt() <= 1;
  }

  bool fromAbove(PositionComponent platform, Player other) {
    return other.velocity.y > 0 &&
        (platform.position.y - (other.position.y + other.height)).toInt() <=
            1 &&
        other.position.x + other.width > platform.x &&
        other.position.x < platform.x + platform.width;
  }

  bool fromBelow(PositionComponent platform, Player other) {
    return (platform.position.y + platform.height - (other.position.y))
                .toInt() <=
            1 &&
        other.position.x + other.width > platform.x &&
        other.position.x < platform.x + platform.width;
  }

  void resolveCollisionFromAbove(PositionComponent other) {
    // Player is standing on the platform, adjust player's position
    other.position.y = y - other.height;
    if (other is Player) other.isGrounded = true;
  }

  void resolveCollisionFromBelow(PositionComponent other) {
    // Player is colliding from below, adjust position
    other.y = y + height;
    if (other is Player) other.velocity.y = 0;
  }

  void resolveCollisionFromLeft(PositionComponent other) {
    // Adjust horizontal position only
    other.x = x - other.width;
  }

  void resolveCollisionFromRight(PositionComponent other) {
    // Adjust horizontal position only
    other.x = x + width;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      if (other.fromAbove(this) &&
          (!other.fromRight(this) && !other.fromLeft(this))) {
        resolveCollisionFromAbove(other);
      }
      if (other.fromBelow(this) &&
          !other.fromRight(this) &&
          !other.fromLeft(this)) {
        resolveCollisionFromBelow(other);
      } else if (other.fromLeft(this)) {
        resolveCollisionFromLeft(other);
      }
      if (other.fromRight(this)) {
        resolveCollisionFromRight(other);
      }
    }
    super.onCollision(intersectionPoints, other);
  }
}
