import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:gomi/game/gomi_map.dart';
import 'package:gomi/router.dart';

class LevelButton extends SpriteComponent
    with TapCallbacks, HasWorldReference<Map> {
  bool isLocked;
  int levelNumber;
  LevelButton(
      {super.size,
      required this.levelNumber,
      super.position,
      required this.isLocked});
  @override
  FutureOr<void> onLoad() async {
    final levelButtonImage = await Flame.images.load("level_button.png");
    final emptyLevelButtonImage =
        await Flame.images.load("empty_level_button.png");

    sprite = Sprite(isLocked ? emptyLevelButtonImage : levelButtonImage);
    final text = TextComponent(
      textRenderer: TextPaint(
          style: const TextStyle(
              fontFamily: "Press Start 2P", color: Colors.lightBlue)),
      scale: Vector2(5, 5),
      anchor: Anchor.center,
      text: levelNumber.toString(),
    );
    text.position = Vector2(x + width / 2, y + height / 2 - text.height);
    if (!isLocked) world.add(text);
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (!isLocked) router.go('/play/session/$levelNumber');
    super.onTapUp(event);
  }
}
