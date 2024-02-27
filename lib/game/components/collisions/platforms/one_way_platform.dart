import 'package:flame/components.dart';
import 'package:gomi/game/components/collisions/platforms/platform.dart';
import 'package:gomi/game/components/entities/player.dart';

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

  @override
  bool fromAbove(PositionComponent platform, Player other) {
    return (platform.position.y - (other.position.y + other.height)).toInt() <=
            1 &&
        (platform.position.y - (other.position.y + other.height)).toInt() >=
            -other.height / 2 &&
        other.position.x + other.width > platform.x &&
        other.position.x < platform.x + platform.width;
  }
}
