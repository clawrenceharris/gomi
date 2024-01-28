import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/components/actors/enemy.dart';
import 'package:gomi/components/actors/player.dart';
import 'package:gomi/constants/globals.dart';

class BottleEnemy extends Enemy with HasCollisionDetection, CollisionCallbacks {
  BottleEnemy({
    position,
    required double attackWidth,
  })  : _attackWidth = attackWidth,
        super(position: position) {
    _attackWidth = attackWidth;
  }
  double _attackWidth;
  late double _startX;
  late double _endX;
  double _direction = 1;

  final double _speed = 90;
  @override
  Future<void> onLoad() async {
    _startX = position.x;
    _endX = position.x + _attackWidth;
    position.x = position.x + _attackWidth / 2;
    return super.onLoad();
  }

  @override
  void loadAllAnimations() {
    idleAnimation = spriteAnimation("Idle", 9, Vector2(18, 25));
    attackAnimation = spriteAnimation("Attack", 11, Vector2(18, 25));
    super.loadAllAnimations();

    animations = {
      EnemyState.idle: idleAnimation,
      EnemyState.attacking: attackAnimation
    };
  }

  @override
  SpriteAnimation spriteAnimation(
      String state, int amount, Vector2 textureSize) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache('Enemies/Water Bottle/$state.png'),
        SpriteAnimationData.sequenced(
            amount: amount,
            stepTime: Globals.animationStepTime,
            textureSize: textureSize));
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
