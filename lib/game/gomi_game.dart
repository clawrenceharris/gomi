import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:gomi/game/gomi_world.dart';

class Gomi extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  @override
  final World world = GomiWorld();

  @override
  FutureOr<void> onLoad() async {
    //Load all images into cache
    await images.loadAllImages();

    add(world);
    return super.onLoad();
  }
}
