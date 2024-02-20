import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomi/game/components/parallax_background.dart';
import 'package:gomi/game/utils.dart';
import 'package:gomi/level_selection/level_button.dart';
import 'package:gomi/player_progress/player_progress.dart';

class GomiWorldMap extends FlameGame<Map> {
  final PlayerProgress playerProgress;
  GomiWorldMap({
    required this.playerProgress,
  }) : super(world: Map(playerProgress: playerProgress));
  @override
  Future<void> onLoad() async {
    await images.loadAllImages();
  }
}

class Map extends World with HasGameRef<GomiWorldMap> {
  // Variables
  late TiledComponent map;
  final PlayerProgress playerProgress;
  Map({required this.playerProgress});
  late final CameraComponent cam;
  final Vector2 _visibleGameArea = Vector2(1500, 1500);
  Vector2 get size => (parent as FlameGame).size;
  final cameraParallax = ParallaxBackground(speed: 0, layers: [
    ParallaxImageData('scenery/water.png'),
  ]);
  final int mapTileSize = 64;

  // Functions
  @override
  Future<void> onLoad() async {
    //load the tiled level
    map = await TiledComponent.load(
        'level_map.tmx', Vector2.all(mapTileSize.toDouble()));
    add(map);

    _setUpCamera();
    _addLevelButtons();
  }

  void _addLevelButtons() async {
    final layer = getTiledLayer(map, "level buttons");

    for (final obj in layer.objects) {
      final levelNumber = obj.properties.getValue("Level Number");
      late final bool isLocked;
      if (playerProgress.levels.length < levelNumber - 1) {
        isLocked = true;
      } else if (playerProgress.levels.length >= levelNumber - 1) {
        isLocked = false;
      }
      add(LevelButton(
          position: Vector2(obj.x, obj.y),
          levelNumber: levelNumber,
          size: Vector2(obj.width, obj.height),
          isLocked: isLocked));
    }
  }

  void _setUpCamera() {
    game.camera = CameraComponent(
        world: this, viewport: FixedAspectRatioViewport(aspectRatio: 16 / 10))
      ..viewport.size = size
      ..viewfinder.visibleGameSize = _visibleGameArea
      ..viewfinder.anchor = Anchor.topLeft;

    PositionComponent pc = PositionComponent(position: Vector2(0, 0));
    game.camera.follow(pc);
    game.camera.backdrop.add(cameraParallax);
  }
}
