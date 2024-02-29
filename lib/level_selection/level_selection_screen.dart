import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gomi/audio/audio_controller.dart';
import 'package:gomi/game/gomi_map.dart';
import 'package:gomi/game/widgets/sound_button.dart';
import 'package:provider/provider.dart';
import '../player_progress/player_progress.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final playerProgress = context.watch<PlayerProgress>();
    final audioController = context.watch<AudioController>();

    return Stack(
      children: [
        GameWidget<GomiWorldMap>(
            game: GomiWorldMap(
                playerProgress: playerProgress,
                audioController: audioController),
            key: const Key("level selection")),

        // Button positioned in the top right corner

        const Positioned(
          top: 10,
          right: 10,
          child: Align(alignment: Alignment.topRight, child: SoundButton()),
        ),
      ],
    );
  }
}
