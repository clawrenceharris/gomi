import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/game/components/powerups/powerup.dart';

class Spike extends Powerup {
  Spike({super.position});

  @override
  int get coins => 30;

  @override
  String get name => "The Spike Surge";

  @override
  String get description =>
      "Fend off Litter Critters by tossing\nspikes in the air.";

  @override
  String get image => "powerups/spike.png";
  @override
  double get duration => 1.3;
  @override
  double get speed => 90;
  @override
  double get jumpForce => 360;
  @override
  RectangleHitbox get hitbox => RectangleHitbox(
      position: Vector2(position.x + width - 10, position.y),
      size: Vector2(10, height));

  @override
  int get points => 300;

  @override
  void update(double dt) {
    applyPhysics(dt, world);
    _updateVelocity();
    _updateMovement(dt);
    super.update(dt);
  }

  void _updateVelocity() {
    velocity.x = speed * direction;
  }

  void _updateMovement(double dt) {
    direction = world.player.scale.x < 0 ? -1 : 1;

    position.x += velocity.x * dt;
  }

  @override
  void activate() {
    position = world.player.position;
    velocity.y = -jumpForce;

    angle = pi / 2;
    super.activate();
  }
}
