import 'package:flame/src/components/position_component.dart';
import 'package:gomi/game/components/collisions/platforms/platform.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'package:vector_math/vector_math_64.dart';

class Water extends Platform {
  Water({super.position, super.size});

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      other.hit();
    }
    super.onCollision(intersectionPoints, other);
  }
}
