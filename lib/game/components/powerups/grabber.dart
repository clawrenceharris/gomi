import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'package:gomi/game/components/powerups/powerup.dart';

class Grabber extends Powerup {
  Grabber({super.position});
  late final _coins = 3;

  @override
  int get coins => _coins;

  late final _name = "The Litter Grabber";

  @override
  String get name => _name;

  late final _description =
      "Grab Litter Critters from a distance.\nPress space to activate";

  @override
  String get description => _description;

  late final _image = "assets/images/powerups/grabber.png";

  @override
  String get image => _image;
  double elapsedTime = 0.0;
  double activeTime = 0.5;

  @override
  FutureOr<void> onLoad() async {
    // Load the image
    var image = await Flame.images.load("powerups/grabber.png");

    // Create the sprite with the loaded image
    sprite = Sprite(image);

    // Set the size of the sprite if needed
    return super.onLoad();
  }

  @override
  void update(double dt) {
    elapsedTime += dt;

    if (elapsedTime >= activeTime) {
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
