import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/entities/enemies/enemy.dart';

class BulbEnemy extends Enemy {
  BulbEnemy({super.position, required super.player});

  @override
  void attack(double dt) {
    // TODO: implement attack
  }
  @override
  void loadAllAnimations() {
    idleAnimation = AnimationConfigs.bulbEnemy.idle();
    attackAnimation = AnimationConfigs.bulbEnemy.attacking();
    super.loadAllAnimations();
  }
}
