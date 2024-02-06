import 'package:gomi/audio/audio_controller.dart';
import 'package:gomi/game/gomi_game.dart';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gomi/game/widgets/pause_button.dart';
import 'package:gomi/game/widgets/sound_button.dart';
import 'package:gomi/level_selection/levels.dart';
import 'package:gomi/player_progress/player_progress.dart';
import 'package:provider/provider.dart';

/// This widget defines the properties of the game screen.
/// and passes the audioController in to the
/// [Gomi] class so that it can play audio.
class GameScreen extends StatelessWidget {
  const GameScreen({required this.level, super.key});

  final GameLevel level;

  @override
  Widget build(BuildContext context) {
    final audioController = context.read<AudioController>();
    return Stack(
      children: [
        GameWidget<Gomi>(
            key: const Key('play session'),
            game: Gomi(
              level: level,
              playerProgress: context.read<PlayerProgress>(),
              audioController: audioController,
            )),

        // Button positioned in the top right corner
        const Positioned(
          top: 10,
          right: 70,
          child: Align(alignment: Alignment.topRight, child: PauseButton()),
        ),
        const Positioned(
          top: 10,
          right: 10,
          child: Align(alignment: Alignment.topRight, child: SoundButton()),
        ),
      ],
    );
  }
}
