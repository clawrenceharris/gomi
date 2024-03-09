import 'package:flame/components.dart';
import 'package:gomi/game/components/entities/entity_state.dart';
import 'package:gomi/game/gomi_level.dart';

class GomiEntity extends SpriteAnimationGroupComponent<GomiEntityState>
    with HasWorldReference<GomiLevel> {
  GomiEntity({super.size, super.position, super.anchor});
  late final double speed;
  int direction = 0;

  bool gotHit = false;

  late final Vector2 initialPosition;

  final double gravity = 9.8;
  double jumpCooldown = 1.5;
  bool isGrounded = false;
  final double bounceForce = 200;
  double lastJumpTimestamp = 0.0;
  final double jumpForce = 200;
  final double maxVelocity = 300;
  Vector2 velocity = Vector2.zero();

  void applyPhysics(double dt) {
    world.checkHorizontalCollisions(this, world.visiblePlatforms);
    applyGravity(dt);
    world.checkVerticalCollisions(this, world.visiblePlatforms);
  }

  void applyGravity(double dt) {
    velocity.y += gravity;
    velocity.y = velocity.y.clamp(-jumpForce, maxVelocity);
    position.y += velocity.y * dt;
  }
}
