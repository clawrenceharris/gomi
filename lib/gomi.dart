import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/widgets.dart';
import 'package:gomi/components/levels/level.dart';
import 'package:gomi/components/levels/level_option.dart';

class Gomi extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  late final CameraComponent cam;
  late TiledComponent level;

  @override
  final World world = Level(LevelOption.level_1);
  @override
  FutureOr<void> onLoad() async {
    //Load all images into cache
    await images.loadAllImages();

    cam = CameraComponent.withFixedResolution(
        world: world, width: 450, height: 285)
      ..viewport.anchor = Anchor.topCenter;

    addAll([cam, world]);
    return super.onLoad();
  }
}

// Safety Paste
