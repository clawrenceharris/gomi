import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/game/components/entities/enemies/enemy.dart';

class SyringeEnemy extends Enemy {
  double _rangeNeg = 0;
  double _rangePos = 0;
  Vector2 velocity = Vector2.zero();
  int _targetDirection = -1;
  final double _speed = 100;
  final int offNeg; //alloted spaces to the left the eneymy can move
  final int offPos; //alloted spaces to the right the eneymy can move
  double moveDirection = 1;
  SyringeEnemy(
      {super.position,
      required super.player,
      this.offNeg = 0,
      this.offPos = 0});

  @override
  FutureOr<void> onLoad() {
    // debugMode = true;
    _calculateRange();
    isAttacking = true;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updateState();

    super.update(dt);
  }

  @override
  void loadAllAnimations() {
    idleAnimation = AnimationConfigs.syringeEnemy.idle();
    attackAnimation = AnimationConfigs.syringeEnemy.idle();
    super.loadAllAnimations();
  }

  void _calculateRange() {
    _rangeNeg = position.x - offNeg * Globals.tileSize;
    _rangePos = position.x + offPos * Globals.tileSize;
  }

  @override
  bool playerIsCorrectColor() {
    return player.color.toLowerCase() == "red";
  }

  @override
  void attack(double dt) {
    velocity.x = 0;
    double offset = (scale.x > 0) ? 0 : -width;

    if (playerInRange()) {
      //if the player is to the right of the enemy set direction to the right and vise versa
      _targetDirection = (player.x < position.x + offset) ? -1 : 1;
      velocity.x = _targetDirection * _speed;
    }
    moveDirection = lerpDouble(moveDirection, _targetDirection, 0.1) ?? 1;
    position.x += velocity.x * dt;
  }

  bool playerInRange() {
    return player.x >= _rangeNeg &&
        player.x <= _rangePos &&
        player.y + player.height > position.y &&
        player.y < position.y + height;
  }

  void _updateState() {
    current = (velocity.x != 0) ? EnemyState.attacking : EnemyState.idle;

    if (moveDirection > 0 && scale.x > 0 || moveDirection < 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }
  }
}
