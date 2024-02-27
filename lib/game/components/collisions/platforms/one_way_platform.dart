import 'package:gomi/game/components/collisions/platforms/platform.dart';
import 'package:gomi/game/components/entities/gomi_entity.dart';

class OneWayPlatform extends Platform {
  OneWayPlatform({super.position, super.size});

  @override
  void resolveCollisionFromBottom(GomiEntity player) {
    // do nothing
  }

  @override
  void resolveCollisionFromRight(GomiEntity player) {
    // do nothing
  }

  @override
  void resolveCollisionFromLeft(GomiEntity player) {
    // do nothing
  }
}
