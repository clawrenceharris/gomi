import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/collisions/platforms/platform.dart';
import 'package:gomi/game/components/entities/enemies/enemy.dart';
import 'package:gomi/game/components/entities/player.dart';

class TomatoEnemy extends Enemy {
  final double enemyHeight = 32;
  late final double _jumpForce;
  @override
  late final SpriteAnimation groundAnimation;
  late final SpriteAnimation risingAnimation;
  late final SpriteAnimation apexAnimation;
  late final SpriteAnimation fallingAnimation;

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
    attackTime = 10;
    return super.onLoad();
  }

  @override
  void loadAllAnimations() {
    groundAnimation = AnimationConfigs.tomatoEnemy.ground();
    risingAnimation = AnimationConfigs.tomatoEnemy.rising();
    apexAnimation = AnimationConfigs.tomatoEnemy.apex();
    fallingAnimation = AnimationConfigs.tomatoEnemy.falling();

    animations = {
      GomiEntityState.idle: groundAnimation,
      GomiEntityState.attacking: groundAnimation,
      GomiEntityState.ground: groundAnimation,
      GomiEntityState.rising: risingAnimation,
      GomiEntityState.apex: apexAnimation,
      GomiEntityState.falling: fallingAnimation,
    };

    current = GomiEntityState.idle;
  }

  @override
  void playHitSfx() {
    game.audioController.playSfx(SfxType.compostEnemy);
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
    applyPhysics(dt);
    customStates();
    _attack(dt);
  }

  void customStates() {
    if (isGrounded == true) {
      current = GomiEntityState.ground;
      return;
    }

    if (!isGrounded && velocity.y <= -1) {
      current = GomiEntityState.rising;
      return;
    }

    if (!isGrounded && velocity.y == 0) {
      current = GomiEntityState.apex;
      return;
    }

    if (!isGrounded && velocity.y >= 1) {
      current = GomiEntityState.falling;
      return;
    }
  }
}
