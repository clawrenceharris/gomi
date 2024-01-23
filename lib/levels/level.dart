import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:logger/logger.dart';
import 'package:gomi/constants/globals.dart';

class Level extends World {
  late TiledComponent levelMap;
  @override
  FutureOr<void> onLoad() async {
    levelMap =
        await TiledComponent.load(Globals.lv_1, Vector2.all(Globals.tileSize));

    add(levelMap);
    return super.onLoad();
  }
}
