import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:gomi/game/components/collision%20blocks/collision_block.dart';

class Water extends CollisionBlock {
  Water({position, size}) : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(collisionType: CollisionType.passive));
    return super.onLoad();
  }
}
