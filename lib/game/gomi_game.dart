import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gomi/game/gomi_level.dart';
import 'package:gomi/player_stats/player_health.dart';
import 'package:gomi/player_stats/player_score.dart';

import '../audio/audio_controller.dart';
import '../level_selection/levels.dart';
import '../player_progress/player_progress.dart';

class Gomi extends FlameGame<GomiLevel>
    with HasCollisionDetection, KeyboardEvents {
  Gomi({
    required this.level,
    required PlayerProgress playerProgress,
    required PlayerHealth playerHealth,
    required PlayerScore playerScore,
    required this.audioController,
  }) : super(
          world: GomiLevel(
              level: level,
              playerScore: playerScore,
              playerProgress: playerProgress,
              playerHealth: playerHealth),
        ) {
    instance = this;
  }
  late final Gomi instance;
  final GameLevel level;

  final AudioController audioController;

  @override
  Future<void> onLoad() async {
    //Load all images into cache
    await images.loadAllImages();
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    world.player.directionX = 0;
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);
    world.player.directionX += isLeftKeyPressed ? -1 : 0;
    world.player.directionX += isRightKeyPressed ? 1 : 0;

    if (keysPressed.contains(LogicalKeyboardKey.space) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      world.player.hasJumped = true;
    }

    return super.onKeyEvent(event, keysPressed);
  }
}
