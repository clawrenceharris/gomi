import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/entities/enemies/enemy.dart';
import 'package:gomi/game/components/entities/player.dart';

class BottleEnemy extends Enemy with HasCollisionDetection, CollisionCallbacks {
  final double offNeg;
  final double offPos;
  final double attackWidth;
  BottleEnemy({
    super.position,
    this.offNeg = 0,
    this.offPos = 0,
    this.attackWidth = 0,
  }) {
    _startX = position.x;
    _endX = position.x + attackWidth;
    position.x = position.x + attackWidth / 2;
  }
  late double _startX;
  late double _endX;
  double _direction = 1;

  final double _speed = 90;

  @override
  void loadAllAnimations() {
    idleAnimation = AnimationConfigs.bottleEnemy.idle();

    attackAnimation = AnimationConfigs.bottleEnemy.attacking();
    super.loadAllAnimations();
  }

  void _attack(dt) {
    // Check if the enemy has reached the end or start position
    if (_direction == 1 && position.x >= _endX) {
      _direction = -1; // Change direction to left
      flipHorizontallyAroundCenter();
    } else if (_direction == -1 && position.x <= _startX) {
      flipHorizontallyAroundCenter();
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

    // Check if enemy is attacking
    if (isAttacking) {
      _attack(dt);
    }
  }

  void switchToIdle() {
    isAttacking = false;
    elapsedTime = 0.0; // Reset the elapsed time for the new state
    current = EnemyState.idle;
  }

  void switchToAttack() {
    isAttacking = true;
    elapsedTime = 0.0; // Reset the elapsed time for the new state
    current = EnemyState.attacking;
    _direction *= -1;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      // interact with player
      switch (current) {
        case EnemyState.attacking:
          //TODO: attack the player
          break;
        case EnemyState.idle:
          //TODO: remove enemy from game
          super.remove(this);
          break;
        default:
          break;
      }
    }
    super.onCollision(intersectionPoints, other);
  }
}
