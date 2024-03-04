import 'package:flame/components.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'package:gomi/game/gomi_level.dart';

abstract class GomiEntity extends SpriteAnimationGroupComponent<GomiEntityState>
    with HasWorldReference<GomiLevel> {
  GomiEntity({super.size, super.position, super.anchor});
  final double speed = 0;
  int direction = 0;

  bool gotHit = false;

  late final Vector2 initialPosition = Vector2(position.x, position.y);
}
