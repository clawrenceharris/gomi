import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/entities/enemies/enemy.dart';

class BottleEnemy extends Enemy {
  final double attackWidth;
  BottleEnemy({
    super.position,
    this.startX = 0,
    required super.player,
    this.endX = 0,
    this.attackWidth = 0,
  });
  final int startX;
  final int endX;
  double _direction = 1;

  final double _speed = 90;

  @override
  void loadAllAnimations() {
    idleAnimation = AnimationConfigs.bottleEnemy.idle();

    attackAnimation = AnimationConfigs.bottleEnemy.attacking();
    super.loadAllAnimations();
  }

  @override
  void attack(double dt) {
    // Check if the enemy has reached the end or start position
    if (_direction == 1 && position.x >= endX) {
      _direction = -1; // Change direction to left
    } else if (_direction == -1 && position.x <= startX) {
      _direction = 1; // Change direction to right
    }

    // Update the position based on speed and direction
    position.x += _speed * _direction * dt;
  }

  @override
  void update(double dt) {
    super.update(dt);
    elapsedTime += dt;

    // Check if it's time to switch states
    if (isAttacking && elapsedTime >= attackTime) {
      switchToIdle();
    } else if (!isAttacking && elapsedTime >= idleTime) {
      switchToAttack();
    }
  }

  @override
  void switchToAttack() {
    super.switchToAttack();
    _direction *= -1;
  }
}
