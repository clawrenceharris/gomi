import 'dart:async';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/entities/enemies/enemy.dart';

class SyringeEnemy extends Enemy {
  final double offNeg;
  final double offPos;

  SyringeEnemy({super.position, this.offNeg = 0, this.offPos = 0});

  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    return super.onLoad();
  }

  @override
  void loadAllAnimations() {
    idleAnimation = AnimationConfigs.syringeEnemy.idle();
    attackAnimation = AnimationConfigs.syringeEnemy.attacking();
    super.loadAllAnimations();
  }
}
