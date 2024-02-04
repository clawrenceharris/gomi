import 'package:flame/components.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/entities/enemies/enemy.dart';
import 'package:gomi/game/components/entities/enemies/zap.dart';

class BulbEnemy extends Enemy {
  final int direction;
  BulbEnemy({required this.direction, super.position, required super.player});
  double _elapsedTime = 0.0; // Accumulated time for the current state
  double zapCoolDown = 3;
  @override
  void attack(double dt) {
    _elapsedTime += dt;
    if (_elapsedTime >= zapCoolDown) {
      game.world.add(Zap(
          position: Vector2(position.x, position.y + height / 2),
          direction: direction));
      _elapsedTime = 0.0;
    }
  }

  @override
  void update(double dt) {
    if (isAttacking && elapsedTime >= attackTime) {
      switchToIdle();
    } else if (!isAttacking && elapsedTime >= idleTime) {
      switchToAttack();
    }
    super.update(dt);
  }

  @override
  void loadAllAnimations() {
    idleAnimation = AnimationConfigs.bulbEnemy.idle();
    attackAnimation = AnimationConfigs.bulbEnemy.attacking();
    super.loadAllAnimations();
  }
}
