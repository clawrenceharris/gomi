import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/game/components/parallax_background.dart';
import 'package:gomi/game/gomi_level.dart';
import 'package:gomi/game/utils.dart';
import 'package:gomi/game/world_map.dart';
import 'package:gomi/level_selection/levels.dart';
import 'package:gomi/player_progress/player_progress.dart';

class GomiMap extends FlameGame<WorldMap> {
  late TiledComponent map;
  GomiMap() : super(world: WorldMap());
  @override
  Future<void> onLoad() async {
    await images.loadAllImages();
  }

  void _setUpCamera() {}
}
