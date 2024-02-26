import 'package:flame/components.dart';
import 'package:gomi/game/components/collisions/platforms/platform.dart';

class OneWayPlatform extends Platform {
  OneWayPlatform({super.position, super.size});

  @override
  void resolveCollisionFromBelow(PositionComponent other) {
    // do nothing
  }

  @override
  void resolveCollisionFromLeft(PositionComponent other) {
    // do nothing
  }

  @override
  void resolveCollisionFromRight(PositionComponent other) {
    // do nothing
  }
}
