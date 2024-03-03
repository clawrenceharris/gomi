import 'package:flame/components.dart';
import 'package:gomi/game/components/entities/player.dart';

abstract class GomiEntity
    extends SpriteAnimationGroupComponent<GomiEntityState> {
  GomiEntity({super.size, super.position, super.anchor});
  Vector2 velocity = Vector2.zero();
  final double speed = 0;
  int direction = 0;
  final double gravity = 9.8;
  double jumpCooldown = 1.5;
  bool gotHit = false;
  final double jumpForce = 200;
  bool isGrounded = false;
  double lastJumpTimestamp = 0.0;
  final double maxVelocity = 300;
  final double bounceForce = 200;
  late final Vector2 initialPosition;
}
