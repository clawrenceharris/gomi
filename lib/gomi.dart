import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomi/level.dart';

class Gomi extends FlameGame {
  late final CameraComponent cam;
  late TiledComponent level;
  @override
  final World world = Level();
  @override
  FutureOr<void> onLoad() async {
    //Load all images into cache
    await images.loadAllImages();

    cam = CameraComponent.withFixedResolution(
        world: world, width: 900, height: 540)
      ..viewfinder.anchor = Anchor.topLeft
      ..viewfinder.position = Vector2(0, 0);

    addAll([cam, world]);
    return super.onLoad();
  }
}
