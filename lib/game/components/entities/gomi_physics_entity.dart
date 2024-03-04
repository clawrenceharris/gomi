import 'package:flame/components.dart';
import 'package:gomi/game/components/entities/gomi_entity.dart';

///an entity or actor in the game that should have gravity and collisions applied to it
class GomiPhysicsEntity extends GomiEntity {
  GomiPhysicsEntity({super.size, super.position, super.anchor});
  final double gravity = 9.8;
  double jumpCooldown = 1.5;
  bool isGrounded = false;
  final double bounceForce = 200;
  double lastJumpTimestamp = 0.0;
  final double jumpForce = 200;
  final double maxVelocity = 300;
  Vector2 velocity = Vector2.zero();

  @override
  void update(double dt) {
    world.checkHorizontalCollisions(this, world.visiblePlatforms);

    applyGravity(dt);
    world.checkVerticalCollisions(this, world.visiblePlatforms);

    super.update(dt);
  }

  void applyGravity(double dt) {
    velocity.y += gravity;
    velocity.y = velocity.y.clamp(-jumpForce, maxVelocity);
    position.y += velocity.y * dt;
  }
}
