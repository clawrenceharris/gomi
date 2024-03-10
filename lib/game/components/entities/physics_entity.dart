import 'package:flame/components.dart';
import 'package:gomi/game/components/collisions/platforms/platform.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'package:gomi/game/gomi_level.dart';

mixin PhysicsEntity on PositionComponent {
  final double gravity = 9.8;
  bool isGrounded = false;
  final double maxVelocity = 300;
  int direction = 0;

  double jumpCooldown = 1.5;
  final double bounceForce = 200;
  final double jumpForce = 200;
  Vector2 velocity = Vector2.zero();
  final bool collisionsEnabled = true;
  double lastJumpTimestamp = 0.0;

  void applyPhysics(double dt, GomiLevel world) {
    Iterable<Platform> platforms =
        this is Player ? world.visiblePlatforms : world.platforms;

    if (collisionsEnabled) {
      world.checkHorizontalCollisions(this, platforms);
      applyGravity(dt);
      world.checkVerticalCollisions(this, platforms);
    } else {
      applyGravity(dt);
    }
  }

  void applyGravity(double dt) {
    velocity.y += gravity;
    velocity.y = velocity.y.clamp(-jumpForce, maxVelocity);
    position.y += velocity.y * dt;
  }
}
