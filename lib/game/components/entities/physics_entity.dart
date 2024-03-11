import 'package:flame/components.dart';
import 'package:gomi/game/gomi_level.dart';

mixin PhysicsEntity on PositionComponent {
  final double gravity = 9.8;
  bool isGrounded = false;
  final double maxVelocity = 300;
  int direction = 0;
  late final double speed;
  double jumpCooldown = 1.5;
  final double bounceForce = 0;
  final double jumpForce = 0;
  Vector2 velocity = Vector2.zero();
  double lastJumpTimestamp = 0.0;

  void applyPhysics(double dt, GomiLevel world) {
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
