import 'package:gomi/audio/audio_controller.dart';
import 'package:gomi/game/gomi_game.dart';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gomi/game/widgets/game_win_dialog.dart';
import 'package:gomi/level_selection/levels.dart';
import 'package:gomi/player_progress/player_progress.dart';
import 'package:provider/provider.dart';

/// This widget defines the properties of the game screen.
/// and passes the audioController in to the
/// [Gomi] class so that it can play audio.
class GameScreen extends StatelessWidget {
  const GameScreen({required this.level, super.key});
  final GameLevel level;
  static const String winDialogKey = 'win_dialog';

  @override
  Widget build(BuildContext context) {
    final audioController = context.read<AudioController>();
    return Scaffold(
      body: GameWidget<Gomi>(
        key: const Key('play session'),
        game: Gomi(
          level: level,
          playerProgress: context.read<PlayerProgress>(),
          audioController: audioController,
        ),
        overlayBuilderMap: {
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
