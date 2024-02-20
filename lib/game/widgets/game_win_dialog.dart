import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gomi/level_selection/levels.dart';
import 'package:gomi/style/palette.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

/// This dialog is shown when a level is completed.
///
/// It shows what time the level was completed in and if there are more levels
/// it lets the user go to the next level, or otherwise back to the level
/// selection screen.
class GameWinDialog extends StatelessWidget {
  const GameWinDialog({
    super.key,
    required this.level,
    required this.stars,
  });

  /// The properties of the level that was just finished.
  final GameLevel level;

  /// How many seconds that the level was completed in.
  final int stars;

  //NesContainer Height and Width
  final double cwidth = 420;
  final double cheight = 284;

  @override
  Widget build(BuildContext context) {
    final palette = context.read<Palette>();
    return Center(
      child: NesContainer(
        width: cwidth,
        height: cheight,
        backgroundColor: palette.backgroundPlaySession.color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Well done!',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'You completed level ${level.number} and earned $stars.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (level.number < gameLevels.length) ...[
              NesButton(
                onPressed: () {
                  context.go('/play/session/${level.number + 1}');
                },
                type: NesButtonType.primary,
                child: const Text('Next level'),
              ),
              const SizedBox(height: 16),
            ],
            NesButton(
              onPressed: () {
                context.go('/play');
              },
              type: NesButtonType.normal,
              child: const Text('Level selection'),
            ),
          ],
        ),
      ),
    );
  }
}
