import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/game/components/parallax_background.dart';
import 'package:gomi/game/gomi_map.dart';
import 'package:gomi/game/utils.dart';
import 'package:gomi/game/world_map.dart';

class WorldMap extends World with HasGameRef<GomiMap> {
  late TiledComponent map;
  late final CameraComponent cam;
  Vector2 get size => (parent as FlameGame).size;
  final cameraParallax = ParallaxBackground(speed: 0, layers: [
    ParallaxImageData('scenery/background_1a.png'),
  ]);
  final int mapTileSize = 64;
  @override
  Future<void> onLoad() async {
    //load the tiled level
    map = await TiledComponent.load(
        'level_map.tmx', Vector2.all(mapTileSize.toDouble()));
    add(map);

    //level bounds will start 5 tiles to the right
    _setUpCamera();

    //_addLevelButtons();
  }

  void _setUpCamera() {
    game.camera = CameraComponent(
        world: this, viewport: FixedAspectRatioViewport(aspectRatio: 16 / 10))
      ..viewport.size = size
      ..viewfinder.visibleGameSize = Vector2(1500, 1500)
      ..viewfinder.anchor = Anchor.topLeft;

    PositionComponent pc = PositionComponent(position: Vector2(0, 0));
    game.camera.follow(pc);
    // game.camera.setBounds(levelBounds);
    game.camera.backdrop.add(cameraParallax);
  }
}
