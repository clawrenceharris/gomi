import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:gomi/game/components/entities/player.dart';

class PlayerCameraAnchor extends PositionComponent {
  final double offsetX;
  final double offsetY;
  final Player player;
  PlayerCameraAnchor(
      {super.position,
      super.size,
      required this.player,
      required this.offsetX,
      required this.offsetY});
  @override
  void update(double dt) {
    debugMode = true;
    debugColor = Colors.red;
    position =
        Vector2(player.position.x + offsetX, player.position.y + offsetY);
  }
}
