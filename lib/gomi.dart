import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:gomi/levels/level.dart';

class Gomi extends FlameGame {
  late final CameraComponent cam;
  Level level = Level();

  @override
  FutureOr<void> onLoad() async {
    cam = CameraComponent.withFixedResolution(
        world: level, width: 900, height: 540)
      ..viewfinder.anchor = Anchor.topLeft
      ..viewfinder.zoom = 1.0
      ..viewfinder.position = Vector2(0, 0);

    addAll([level, cam]);
    return super.onLoad();
  }
}
