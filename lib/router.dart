import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gomi/credits/credits_screen.dart';
import 'package:gomi/game/game_screen.dart';
import 'package:gomi/instructions/instructions_screen.dart';
import 'package:gomi/main_menu/main_menu_screen.dart';
import 'package:gomi/splash/splash_screen.dart';
import 'level_selection/level_selection_screen.dart';
import 'level_selection/levels.dart';
import 'style/page_transition.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(key: Key('splash')),
      routes: [
        GoRoute(
            path: 'main_menu',
            pageBuilder: (context, state) => buildPageTransition<void>(
                  key: const ValueKey('main menu'),
                  color: Colors.lightBlue,
                  child: const MainMenuScreen(),
                )),
        GoRoute(
            path: 'instructions',
            pageBuilder: (context, state) => buildPageTransition<void>(
                  key: const ValueKey('instructions'),
                  color: Colors.lightBlue,
                  child: const InstructionsScreen(),
                )),
        GoRoute(
            path: 'credits',
            pageBuilder: (context, state) => buildPageTransition<void>(
                  key: const ValueKey('credits'),
                  color: Colors.lightBlue,
                  child: const CreditsScreen(),
                )),
        GoRoute(
          path: 'play',
          pageBuilder: (context, state) => buildPageTransition<void>(
            key: const ValueKey('level selection'),
            color: Colors.lightBlue,
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
                  color: Colors.lightBlue,
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
