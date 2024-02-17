import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gomi/game/gomi_level.dart';

import '../audio/audio_controller.dart';
import '../level_selection/levels.dart';
import '../player_progress/player_progress.dart';

class Gomi extends FlameGame<GomiLevel>
    with HasCollisionDetection, KeyboardEvents {
  Gomi({
    required this.level,
    required PlayerProgress playerProgress,
    required this.audioController,
  }) : super(
          world: GomiLevel(level: level, playerProgress: playerProgress),
        ) {
    instance = this;
  }
  late final Gomi instance;
  final GameLevel level;

  final AudioController audioController;

  @override
  Future<void> onLoad() async {
    //Load all images into cache
    await images.loadAllImages();

    // With the `TextPaint` we define what properties the text that we are going
    // to render will have, like font family, size and color in this instance.
    final textRenderer = TextPaint(
      style: const TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontFamily: 'Press Start 2P',
      ),
    );

    final scoreText = 'Litter Critters: 0 / ${level.winScore}';

    // The component that is responsible for rendering the text that contains
    // the current score.
    final scoreComponent = TextComponent(
      text: scoreText,
      position: Vector2.all(30),
      textRenderer: textRenderer,
    );

    //camera.viewport.add(scoreComponent);

    // add a listener to the points notifier and update the text
    world.scoreNotifier.addListener(() {
      scoreComponent.text =
          scoreText.replaceFirst('0', '${world.scoreNotifier.value}');
    });
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    world.player.directionX = 0;
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);
    world.player.directionX += isLeftKeyPressed ? -1 : 0;
    world.player.directionX += isRightKeyPressed ? 1 : 0;

    if (keysPressed.contains(LogicalKeyboardKey.space) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      world.player.hasJumped = true;
    }

    return super.onKeyEvent(event, keysPressed);
  }
}
