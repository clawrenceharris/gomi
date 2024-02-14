import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gomi/game/gomi_map.dart';
import 'package:gomi/game/widgets/sound_button.dart';
import 'package:gomi/level_selection/instructions_dialog.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../player_progress/player_progress.dart';
import '../style/wobbly_button.dart';
import '../style/palette.dart';
import 'levels.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GameWidget<GomiMap>(game: GomiMap(), key: const Key("play session")),

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
