import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomi/audio/audio_controller.dart';
import 'package:gomi/game/components/parallax_background.dart';
import 'package:gomi/game/utils.dart';
import 'package:gomi/level_selection/level_button.dart';
import 'package:gomi/player_progress/player_progress.dart';

class GomiWorldMap extends FlameGame<Map> {
  final PlayerProgress playerProgress;
  final AudioController audioController;
  GomiWorldMap({
    required this.audioController,
    required this.playerProgress,
  }) : super(
            world: Map(
                playerProgress: playerProgress,
                audioController: audioController));
  @override
  Future<void> onLoad() async {
    await images.loadAllImages();
  }
}

class Map extends World with HasGameRef<GomiWorldMap> {
  // Variables
  late TiledComponent map;
  final PlayerProgress playerProgress;
  final AudioController audioController;
  Map({required this.playerProgress, required this.audioController});
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
        'world_map.tmx', Vector2.all(mapTileSize.toDouble()));
    add(map);

    _setUpCamera();
    _addLevelButtons();
  }

  void _addLevelButtons() async {
    final layer = getTiledLayer(map, "level buttons");

    for (final obj in layer.objects) {
      final int levelNumber = obj.properties.getValue("Level Number");

      late final bool isLocked;

      if (playerProgress.levels.length < levelNumber - 1) {
        isLocked = true;
      } else if (playerProgress.levels.length >= levelNumber - 1) {
        isLocked = false;
      }
      add(LevelButton(
          isBonusLevel: obj.class_.toLowerCase() == "bonus level",
          audioController: audioController,
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

    game.camera.backdrop.add(cameraParallax);
  }
}
