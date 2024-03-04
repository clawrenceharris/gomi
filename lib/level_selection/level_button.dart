import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:gomi/audio/audio_controller.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/game/gomi_map.dart';
import 'package:gomi/router.dart';

class LevelButton extends SpriteComponent
    with TapCallbacks, HasWorldReference<Map> {
  bool isLocked;
  final int levelNumber;
  final AudioController audioController;

  final bool isBonusLevel;
  LevelButton({
    required this.isBonusLevel,
    required this.levelNumber,
    required this.isLocked,
    required this.audioController,
    super.size,
    super.position,
  });
  @override
  FutureOr<void> onLoad() async {
    final levelBtn = await Flame.images.load("level_button.png");
    final bonusLevelBtn = await Flame.images.load("bonus_level_button.png");

    final emptyLevelBtn = await Flame.images.load("empty_level_button.png");

    //if it is locked, use the empty level button, otherwise
    //if it is a bonus level use the bonus level button
    //if not show the regualr level button
    sprite = Sprite(isLocked
        ? emptyLevelBtn
        : isBonusLevel
            ? bonusLevelBtn
            : levelBtn);
    final text = TextComponent(
      textRenderer: TextPaint(
          style: const TextStyle(fontFamily: "Pixel", color: Colors.lightBlue)),
      scale: Vector2(5, 5),
      anchor: Anchor.center,
      text: levelNumber.toString(),
    );
    text.position = Vector2(x + width / 2, y + height / 2 - text.height);
    if (!isLocked && !isBonusLevel) world.add(text);
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (!isLocked) router.go('/play/session/$levelNumber');
    audioController.playSfx(SfxType.buttonTap);
    super.onTapUp(event);
  }
}
