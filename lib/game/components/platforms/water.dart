import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:gomi/game/components/platforms/platform.dart';

class Water extends Platform {
  Water({position, size}) : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(collisionType: CollisionType.passive));
    return super.onLoad();
  }
}
