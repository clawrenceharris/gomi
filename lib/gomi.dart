import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomi/components/levels/level.dart';
import 'package:gomi/components/levels/level_option.dart';

class Gomi extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  @override
  final World world = Level(LevelOption.level_1);
  @override
  FutureOr<void> onLoad() async {
    //Load all images into cache
    await images.loadAllImages();

    add(world);
    return super.onLoad();
  }
}
