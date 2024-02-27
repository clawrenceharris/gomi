import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/collisions/platforms/platform.dart';
import 'package:gomi/game/components/entities/enemies/enemy.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'package:gomi/game/gomi_game.dart';

class TomatoEnemy extends Enemy with HasGameReference<Gomi> {
  final double enemyHeight = 32;
  late final double _jumpForce;

  @override
  double get jumpForce => _jumpForce;

  double _elapsedTime = 0.0;
  final double bounceCoolDown = 1;
  TomatoEnemy({
    required double jumpForce,
    super.position,
  }) {
    _jumpForce = jumpForce;
  }

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(collisionType: CollisionType.passive));
    sfx = SfxType.compostEnemy;
    attackTime = 10;
    return super.onLoad();
  }

  @override
  void loadAllAnimations() {
    idleAnimation = AnimationConfigs.tomatoEnemy.idle();
    attackAnimation = AnimationConfigs.tomatoEnemy.attacking();
    current = GomiEntityState.attacking;
    super.loadAllAnimations();
  }

  @override
  void playDeathSfx(SfxType sfx) {
    game.audioController.playSfx(sfx);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Platform) {
      if (world.checkCollisionTopCenter(this, other)) {
        position.y = other.y - height;
        velocity.y = 0;
        isGrounded = true;
      }
    }

    super.onCollision(intersectionPoints, other);
  }

  void _applyGravity(double dt) {
    velocity.y += gravity;
    velocity.y = velocity.y.clamp(-_jumpForce, maxVelocity);
  }

  void _attack(dt) {
    _elapsedTime += dt;

    if (isGrounded && _elapsedTime >= bounceCoolDown) {
      _jump(dt);

      _elapsedTime = 0.0;
    }
  }

  void _jump(double dt) {
    velocity.y = -_jumpForce;

    isGrounded = false;
  }

  @override
  bool playerIsCorrectColor() {
    return world.player.color == GomiColor.green;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _applyGravity(dt);
    _attack(dt);

    position.y += velocity.y * dt;
  }
}
