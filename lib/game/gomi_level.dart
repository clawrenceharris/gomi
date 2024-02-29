import 'package:flame/camera.dart';
import 'package:flame/experimental.dart';
import 'package:flame/parallax.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/game/components/collisions/collision_aware.dart';
import 'package:gomi/game/components/entities/collectibles/Collectible.dart';
import 'package:gomi/game/components/entities/collectibles/coin.dart';
import 'package:gomi/game/components/entities/enemies/enemy.dart';
import 'package:gomi/game/components/entities/enemies/tomato_enemy.dart';
import 'package:gomi/game/components/info_tile.dart';
import 'package:gomi/game/components/parallax_background.dart';
import 'package:gomi/game/components/entities/enemies/bottle_enemy.dart';
import 'package:gomi/game/components/entities/enemies/syringe_enemy.dart';
import 'package:gomi/game/components/collisions/platforms/platform.dart';
import 'package:gomi/game/components/collisions/platforms/one_way_platform.dart';
import 'package:gomi/game/components/collisions/platforms/water.dart';
import 'package:gomi/game/components/entities/collectibles/gomi_clone.dart';
import 'package:gomi/game/components/entities/collectibles/seed.dart';
import 'package:gomi/game/components/entities/enemies/bulb_enemy.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'package:gomi/game/components/player_camera_anchor.dart';
import 'package:gomi/game/gomi_game.dart';
import 'package:gomi/game/utils.dart';
import 'package:gomi/game/widgets/game_screen.dart';
import 'package:gomi/player_stats/player_health.dart';
import 'package:gomi/player_progress/player_progress.dart';
import 'package:gomi/player_stats/player_score.dart';
import 'package:gomi/router.dart';
import '../level_selection/levels.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class GomiLevel extends World with HasGameRef<Gomi>, CollisionAware {
  late final Player player;
  final GameLevel level;
  late TiledComponent tiledLevel;

  /// Used to see what the current progress of the player is and to update the
  // progress if a level is finished.
  final PlayerProgress playerProgress;

  ///Used to keep track of and manage how many lives the player has
  final PlayerHealth playerHealth;

  ///used to keep track of the player's overall score and coins colleced for a single level
  final PlayerScore playerScore;

  late final Rectangle levelBounds;

  ///all enemies in the level
  List<Enemy> enemies = [];

  ///all coins in the level
  List<Collectible> coins = [];

  final cameraParallax = ParallaxBackground(speed: 0, layers: [
    ParallaxImageData('scenery/background_1a.png'),
    ParallaxImageData('scenery/sun.png'),
    ParallaxImageData('scenery/clouds_2.png'),
    ParallaxImageData('scenery/clouds_1.png'),
    ParallaxImageData('scenery/trees_2.png'),
    ParallaxImageData('scenery/trees_1.png'),
  ]);

  GomiLevel(
      {required this.playerHealth,
      required this.level,
      required this.playerProgress,
      required this.playerScore});
  Vector2 get size => (parent as FlameGame).size;
  Iterable<Enemy> get activeEnemies =>
      enemies.where((element) => contains(element));

  /// all platforms that are visible in the camera
  Iterable<Platform> get visiblePlatforms => platforms
      .where((element) => element.rect.overlaps(game.camera.visibleWorldRect));

  ///the stars earned for the level
  int stars = 0;
  @override
  Future<void> onLoad() async {
    playerScore.reset();
    playerHealth.reset();
    //load the tiled level
    tiledLevel = await TiledComponent.load(
        level.pathname, Vector2.all(Globals.tileSize));

    ///the bounds of the level. It will start will start 8 tiles to the right
    levelBounds = Rectangle.fromPoints(
        Vector2(8 * Globals.tileSize, 0),
        Vector2(
            (tiledLevel.tileMap.map.width.toDouble() - 5) * Globals.tileSize,
            tiledLevel.tileMap.map.height.toDouble() * Globals.tileSize));

    add(tiledLevel);
    _addEnemies();
    _addPlatforms();

    _addPlayer();
    _addGomiClones();
    _addCollectibles();

    if (level.number == 1) _addInfoTiles();

    _setUpCamera();

    //when health changes check if the player has died (ran out of lives) if so restart the level.
    playerHealth.lives.addListener(() {
      if (playerHealth.isDead) {
        game.audioController.playSfx(SfxType.death);
        _restartLevel();
      } else {
        game.audioController.playSfx(SfxType.hit);
      }
    });

    //when level is won, add the win dialogue and set the level to finished in player progrees
    player.seedCollected.addListener(() {
      if (player.seedCollected.value == true) {
        stars = getStarsEarned();
        game.overlays.add(GameScreen.winDialogKey);
        if (playerProgress.levels.length + 1 == level.number) {
          playerProgress.setLevelFinished(level.number, getStarsEarned());
        }
      }
    });
  }

  int getStarsEarned() {
    int coinCount = coins.length;
    double percentage = playerScore.coins.value / coinCount * 100;

    if (percentage >= 1 && percentage <= 20) {
      return 1;
    } else if (percentage >= 21 && percentage <= 99) {
      return 2;
    } else if (percentage >= 100) {
      return 3;
    } else {
      return 0;
    }
  }

  @override
  void onMount() {
    super.onMount();

    game.overlays.add(GameScreen.hudKey);
  }

  @override
  void onRemove() {
    game.overlays.remove(GameScreen.hudKey);
  }

  void _restartLevel() async {
    playerScore.reset();
    playerHealth.reset();
    player.respawn();
    print(level.number);
  }

  @override
  void update(double dt) {
    cameraParallax.speed = player.velocity.x / 2;

    super.update(dt);
  }

  void _addInfoTiles() {
    final layer = getTiledLayer(tiledLevel, "info tiles");

    for (final tile in layer.objects) {
      final infoIndex = tile.properties.getValue("Index");
      InfoTile infoTile = InfoTile(
          index: infoIndex,
          position: Vector2(tile.x, tile.y),
          size: Vector2(tile.width, tile.height));
      add(infoTile);
    }
  }

  void _addPlayer() {
    final layer = getTiledLayer(tiledLevel, "player");

    //there can only be one player in the level so get the first and only one
    final obj = layer.objects[0];
    player = Player(
        playerScore: playerScore,
        playerHealth: playerHealth,
        color: GomiColor.black,
        position: Vector2(obj.x, obj.y));
    add(player);
  }

  void _addPlatforms() {
    final layer = getTiledLayer(tiledLevel, 'collisions');
    List<Platform> platforms = [];
    for (final collision in layer.objects) {
      late final Platform platform;
      switch (collision.class_.toLowerCase()) {
        case "one way platform":
          platform = OneWayPlatform(
            position: Vector2(collision.x, collision.y),
            size: Vector2(collision.width, collision.height),
          );

        case "water":
          platform = Water(
            position: Vector2(collision.x, collision.y),
            size: Vector2(collision.width, collision.height),
          );

        default:
          platform = Platform(
            position: Vector2(collision.x, collision.y),
            size: Vector2(collision.width, collision.height),
          );
      }
      platforms.add(platform);
      add(platform);
    }
    setPlatforms(platforms);
  }

  void _addEnemies() {
    // Get the enemies layer
    final layer = getTiledLayer(tiledLevel, "enemies");

    // Adds each enemy at the TiledObject's position
    for (final obj in layer.objects) {
      late final Enemy enemy;
      switch (obj.class_.toLowerCase()) {
        case 'bulb enemy':
          final direction = obj.properties.getValue("Direction");
          enemy =
              BulbEnemy(position: Vector2(obj.x, obj.y), direction: direction);
          break;
        case 'syringe enemy':
          final offNeg = obj.properties.getValue("offNeg");
          final offPos = obj.properties.getValue("offPos");

          enemy = SyringeEnemy(
              position: Vector2(obj.x, obj.y), offNeg: offNeg, offPos: offPos);

        case 'bottle enemy':
          final offNeg = obj.properties.getValue("Off Neg");
          final offPos = obj.properties.getValue("Off Pos");
          enemy = BottleEnemy(
            offNeg: offNeg,
            offPos: offPos,
            position: Vector2(obj.x, obj.y),
          );

          break;
        case 'tomato enemy':
          final jumpForce = obj.properties.getValue("Jump Force");
          enemy = TomatoEnemy(
              jumpForce: jumpForce, position: Vector2(obj.x, obj.y));

          break;
      }
      add(enemy);
      enemies.add(enemy);
    }
  }

  //creates the trash bin clones
  void _addGomiClones() {
    final layer = getTiledLayer(tiledLevel, "gomi clones");

    for (final TiledObject obj in layer.objects) {
      final String color = obj.properties.getValue("Color");

      late final GomiColor gomiColor;
      switch (color.toLowerCase()) {
        case "black":
          gomiColor = GomiColor.black;
        case "green":
          gomiColor = GomiColor.green;
        case "blue":
          gomiColor = GomiColor.blue;
        case "red":
          gomiColor = GomiColor.red;
        default:
          gomiColor = GomiColor.black;
      }
      final clone =
          GomiClone(color: gomiColor, position: Vector2(obj.x, obj.y));
      add(clone);
    }
  }

  void _addCollectibles() {
    final layer = getTiledLayer(tiledLevel, "collectibles");

    for (final obj in layer.objects) {
      late final Collectible collectible;

      switch (obj.class_.toLowerCase()) {
        case "seed":
          collectible = Seed(position: Vector2(obj.x, obj.y));
          break;
        case "coin":
          collectible = Coin(position: Vector2(obj.x, obj.y));
          coins.add(collectible);
          break;
      }
      add(collectible);
    }
  }

  void _setUpCamera() {
    final viewport = FixedAspectRatioViewport(aspectRatio: size.x / size.y);

    game.camera = CameraComponent(viewport: viewport)
      ..viewport.size = size
      ..viewfinder.anchor = Anchor.center
      ..viewfinder.visibleGameSize =
          Vector2(Globals.tileSize * 17, Globals.tileSize * 13);
    PlayerCameraAnchor playerCameraAnchor = PlayerCameraAnchor(
        offsetX: 3 * Globals.tileSize,
        offsetY: -Globals.tileSize * 2,
        player: player);
    //target that will be used to follow the player at a given offset x and y
    game.add(playerCameraAnchor);

    game.camera.follow(playerCameraAnchor, maxSpeed: 600, snap: true);
    game.camera.setBounds(levelBounds);
    game.camera.backdrop.add(cameraParallax);
  }
}
