import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:gomi/game/components/collision%20blocks/collision_block.dart';

class OneWayPlatform extends CollisionBlock {
  OneWayPlatform({position, size}) : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox());
    return super.onLoad();
  }
}
