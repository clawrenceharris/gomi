import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/levels/level.dart';
import 'package:logger/logger.dart';

class Gomi extends FlameGame {
  late final CameraComponent cam;

  @override
  FutureOr<void> onLoad() async {
    final Logger logger = Logger();
    logger.d("Loading started");

    late TiledComponent map;
    map =
        await TiledComponent.load(Globals.lv_1f, Vector2.all(Globals.tileSize));

    add(map);

    return super.onLoad();
  }
}
