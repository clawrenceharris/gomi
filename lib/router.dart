import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gomi/game/widgets/game_screen.dart';
import 'package:gomi/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'level_selection/level_selection_screen.dart';
import 'level_selection/levels.dart';
import 'style/page_transition.dart';
import 'style/palette.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(key: Key('splash')),
      routes: [
        GoRoute(
          path: 'play',
          pageBuilder: (context, state) => buildPageTransition<void>(
            key: const ValueKey('level selection'),
            color: context.watch<Palette>().backgroundLevelSelection.color,
            child: const LevelSelectionScreen(),
          ),
          routes: [
            GoRoute(
              path: 'session/:level',
              pageBuilder: (context, state) {
                final levelNumber = int.parse(state.pathParameters['level']!);
                final level = gameLevels[levelNumber - 1];
                return buildPageTransition<void>(
                  key: const ValueKey('level'),
                  color: context.watch<Palette>().backgroundPlaySession.color,
                  child: GameScreen(level: level),
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
