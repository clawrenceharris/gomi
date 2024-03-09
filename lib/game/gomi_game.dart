import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gomi/game/gomi_level.dart';
import 'package:gomi/player_stats/player_health.dart';
import 'package:gomi/player_stats/player_powerup.dart';
import 'package:gomi/player_stats/player_score.dart';
import '../audio/audio_controller.dart';
import '../level_selection/levels.dart';
import '../player_progress/player_progress.dart';

class Gomi extends FlameGame<GomiLevel>
    with HasCollisionDetection, KeyboardEvents, TapCallbacks {
  Gomi({
    required this.level,
    required PlayerProgress playerProgress,
    required PlayerHealth playerHealth,
    required PlayerScore playerScore,
    required PlayerPowerup playerPowerup,
    required this.audioController,
  }) : super(
          world: GomiLevel(
              level: level,
              playerPowerup: playerPowerup,
              playerScore: playerScore,
              playerProgress: playerProgress,
              playerHealth: playerHealth),
        );
  final GameLevel level;
  bool showControls = true;
  final AudioController audioController;

  @override
  Future<void> onLoad() async {
    await images.loadAllImages(); //Load all images into cache
  }

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    world.player.direction = 0;
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);
    world.player.direction += isLeftKeyPressed ? -1 : 0;
    world.player.direction += isRightKeyPressed ? 1 : 0;

    if (keysPressed.contains(LogicalKeyboardKey.space) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      world.player.hasJumped = true;
    }
    return super.onKeyEvent(event, keysPressed);
  }
}
