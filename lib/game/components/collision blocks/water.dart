import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/src/components/position_component.dart';
import 'package:gomi/game/components/collision%20blocks/collision_block.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'package:vector_math/vector_math_64.dart';

class Water extends CollisionBlock {
  Water({position, size}) : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(collisionType: CollisionType.passive));
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      other.hit();
    }
  }
}
