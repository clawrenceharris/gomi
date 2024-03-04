import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'package:gomi/game/components/entities/gomi_physics_entity.dart';

class Platform extends PositionComponent with CollisionCallbacks {
  late final Rect rect;
  Platform({super.position, super.size}) : super(anchor: Anchor.topLeft) {
    rect = Rect.fromPoints(
      Offset(x, y), // Top-left corner
      Offset(x + width, y + height), // Bottom-right corner
    );
    add(RectangleHitbox());
  }

  void resolveCollisionFromRight(GomiPhysicsEntity other) {
    if (other.velocity.x < 0) {
      other.velocity.x = 0;
      other.position.x = position.x + width + other.width / 2;
    }
  }

  void resolveCollisionFromLeft(GomiPhysicsEntity other) {
    if (other.velocity.x > 0) {
      other.velocity.x = 0;
      other.position.x = position.x - other.width / 2;
    }
  }

  void resolveCollisionFromBottom(GomiPhysicsEntity other) {
    if (other.velocity.y < 0) {
      other.velocity.y = 0;
      other.position.y = position.y + height;
    }
  }

  void resolveCollisionFromTop(GomiPhysicsEntity other) {
    if (other.velocity.y > 0) {
      other.velocity.y = 0;
      other.position.y = position.y - other.height;
      other.isGrounded = true;
    }
  }
}
