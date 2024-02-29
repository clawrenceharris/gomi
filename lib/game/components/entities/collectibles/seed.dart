import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/widgets.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/entities/collectibles/Collectible.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'package:gomi/game/gomi_game.dart';

class Seed extends Collectible with HasGameRef<Gomi> {
  Seed({
    super.position,
  }) : super(anchor: Anchor.bottomCenter);
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation growingAnimation;
  late final MoveEffect idleMoveEffect;
  late final MoveEffect plantedMoveEffect;
  final int points = 500;
  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    animation = idleAnimation;
    add(RectangleHitbox(collisionType: CollisionType.passive));
    idleMoveEffect = MoveEffect.to(
        Vector2(position.x, position.y - 10),
        EffectController(
            duration: 2,
            alternate: true,
            infinite: true,
            curve: Curves.easeInOut));

    plantedMoveEffect = MoveEffect.to(
        Vector2(position.x, position.y + 14),
        EffectController(
            duration: 2,
            alternate: false,
            infinite: false,
            curve: Curves.easeInOut));
    add(idleMoveEffect);

    return super.onLoad();
  }

  @override
  Future<void> collideWithPlayer(Player player) async {
    if (world.activeEnemies.isEmpty) {
      playSfx();
      player.playerScore.addScore(points);
      add(plantedMoveEffect);
      plantedMoveEffect.onComplete = () async {
        animation = growingAnimation;
        remove(idleMoveEffect);
        await animationTicker?.completed;
        player.seedCollected.value = true;
      };
    }
  }

  void _loadAllAnimations() {
    idleAnimation = AnimationConfigs.seed.idle();
    growingAnimation = AnimationConfigs.seed.growing();
  }

  @override
  void playSfx() {
    game.audioController.playSfx(SfxType.seed);
  }
}
