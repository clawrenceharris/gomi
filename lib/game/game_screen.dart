import 'package:gomi/audio/audio_controller.dart';
import 'package:gomi/game/gomi_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gomi/game/hud/hud.dart';
import 'package:gomi/game/widgets/game_win_dialog.dart';
import 'package:gomi/level_selection/levels.dart';
import 'package:gomi/player_stats/player_health.dart';
import 'package:gomi/player_progress/player_progress.dart';
import 'package:gomi/player_stats/player_powerup.dart';
import 'package:gomi/player_stats/player_score.dart';
import 'package:provider/provider.dart';

/// This widget defines the properties of the game screen.
/// and passes the audioController in to the
/// [Gomi] class so that it can play audio.
class GameScreen extends StatelessWidget {
  const GameScreen({required this.level, super.key});
  final GameLevel level;
  static const String winDialogKey = 'win_dialog';
  static const String hudKey = 'hud_key';

  @override
  Widget build(BuildContext context) {
    final audioController = context.read<AudioController>();
    final playerHealth = context.read<PlayerHealth>();
    final playerScore = context.read<PlayerScore>();
    final playerProgress = context.read<PlayerProgress>();
    final PlayerPowerup playerPowerup = context.read<PlayerPowerup>();

    return Scaffold(
      body: GameWidget<Gomi>(
        key: const Key('play session'),
        game: Gomi(
          playerPowerup: playerPowerup,
          level: level,
          playerScore: playerScore,
          playerProgress: playerProgress,
          playerHealth: playerHealth,
          audioController: audioController,
        ),
        overlayBuilderMap: {
          hudKey: (BuildContext context, Gomi game) {
            return Hud(player: game.world.player);
          },
          winDialogKey: (BuildContext context, Gomi game) {
            return GameWinDialog(
              level: level,
              stars: game.world.stars,
            );
          },
        },
      ),
    );
  }
}
