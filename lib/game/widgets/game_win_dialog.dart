import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gomi/level_selection/levels.dart';
import './button.dart';

/// This dialog is shown when a level is completed.
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

  //Container height and width
  final double cwidth = 600;
  final double cheight = 360;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: cwidth,
        height: cheight,
        decoration: const BoxDecoration(
          color: Colors.transparent, // Set the background color to transparent

          image: DecorationImage(
            image: AssetImage(
                'assets/images/hud/menu_panel.png'), // Replace with your image path
            fit: BoxFit.fill,
          ),
        ),
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
              Button(
                onPressed: () {
                  context.go('/play/session/${level.number + 1}');
                },
                text: 'Next level',
              ),
              const SizedBox(height: 16),
            ],
            Button(
              onPressed: () {
                context.go('/play');
              },
              text: 'Go Back',
            ),
          ],
        ),
      ),
    );
  }
}
