import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gomi/game/components/entities/player.dart';
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
    required PlayerPowerups playerPowerup,
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
    final Player player = world.player;
    final PlayerPowerups playerPowerup = world.playerPowerup;
    player.direction = 0;
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);
    player.direction += isLeftKeyPressed ? -1 : 0;
    player.direction += isRightKeyPressed ? 1 : 0;

    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      player.hasJumped = true;
    }
    if (keysPressed.contains(LogicalKeyboardKey.space)) {
      if (playerPowerup.powerup != null) {
        world.add(playerPowerup.powerup!);
        playerPowerup.powerup?.position = Vector2(
            player.position.x - playerPowerup.powerup!.width,
            player.position.y + player.height / 2);
        playerPowerup.powerup?.activate();
      }
    }
    return super.onKeyEvent(event, keysPressed);
  }
}
