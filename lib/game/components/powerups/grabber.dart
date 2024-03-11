import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'package:gomi/game/components/powerups/powerup.dart';

class Grabber extends Powerup {
  Grabber({super.position});

  @override
  int get coins => 20;

  @override
  String get name => "The Cleanup Claw";

  @override
  String get description => "Grab Litter Critters from a distance.";

  @override
  String get image => "powerups/grabber.png";

  @override
  double get duration => 0.8;

  @override
  int get points => 200;

  @override
  void update(double dt) {
    elapsedTime += dt;

    if (elapsedTime >= duration) {
      elapsedTime = 0.0;
      removeFromParent();
    }

    super.update(dt);
  }

  @override
  void activate() {
    Player player = world.player;
    if (player.scale.x < 0 && scale.x > 0 ||
        player.scale.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }
    position =
        Vector2(player.position.x, player.position.y + player.height / 2);
    add(MoveEffect.to(
        Vector2(
            player.scale.x > 0
                ? position.x + width * 2
                : position.x - width * 2,
            position.y),
        EffectController(
            duration: 2,
            infinite: false,
            curve: Curves.easeInOutCubicEmphasized)));
    super.activate();
  }
}
