import 'package:gomi/game/components/collisions/platforms/platform.dart';
import 'package:gomi/game/components/entities/physics_entity.dart';

class OneWayPlatform extends Platform {
  OneWayPlatform({super.position, super.size});

  @override
  void resolveCollisionFromBottom(PhysicsEntity other) {
    // do nothing
  }

  @override
  void resolveCollisionFromRight(PhysicsEntity other) {
    // do nothing
  }

  @override
  void resolveCollisionFromLeft(PhysicsEntity other) {
    // do nothing
  }
}
