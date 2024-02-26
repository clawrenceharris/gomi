import 'package:flame/camera.dart';
import 'package:flame/experimental.dart';
import 'package:flame/parallax.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomi/constants/globals.dart';
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
import 'package:gomi/game/components/collisions/collision_aware.dart';
import 'package:gomi/game/utils.dart';
import 'package:gomi/game/widgets/game_screen.dart';
import 'package:gomi/player_stats/player_health.dart';
import 'package:gomi/player_progress/player_progress.dart';
import 'package:gomi/player_stats/player_score.dart';
import 'package:gomi/router.dart';
import '../level_selection/levels.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GomiLevel extends World with HasGameRef<Gomi>, CollisionAware {
  late final Player player;
  final GameLevel level;
  late TiledComponent tiledLevel;
  // Used to see what the current progress of the player is and to update the
  // progress if a level is finished.
  final PlayerProgress playerProgress;
  final PlayerHealth playerHealth;
  final PlayerScore playerScore;

  late final Rectangle levelBounds;
  List<Enemy> enemies = [];

  /// In the [scoreNotifier] we keep track of what the current score is, and if
  /// other parts of the code is interested in when the score is updated they
  /// can listen to it and act on the updated value.
  final scoreNotifier = ValueNotifier(0);
  final ValueNotifier<bool> playerHitNotifier = ValueNotifier<bool>(false);

  final cameraParallax = ParallaxBackground(speed: 0, layers: [
    ParallaxImageData('scenery/background_1a.png'),
    ParallaxImageData('scenery/sun.png'),
    ParallaxImageData('scenery/clouds_2.png'),
    ParallaxImageData('scenery/clouds_1.png'),
    ParallaxImageData('scenery/trees_2.png'),
    ParallaxImageData('scenery/trees_1.png'),
  ]);

  late final PlayerCameraAnchor playerCameraAnchor;

  GomiLevel(
      {required this.playerHealth,
      required this.level,
      required this.playerProgress,
      required this.playerScore});
  Vector2 get size => (parent as FlameGame).size;
  Iterable<Enemy> get activeEnemies =>
      enemies.where((element) => contains(element));

  //the stars earned for the level
  int stars = 0;
  @override
  Future<void> onLoad() async {
    //load the tiled level
    tiledLevel = await TiledComponent.load(
        level.pathname, Vector2.all(Globals.tileSize));

    //level bounds will start 5 tiles to the right
    levelBounds = Rectangle.fromPoints(
        Vector2(8 * Globals.tileSize, 0),
        Vector2(
            (tiledLevel.tileMap.map.width.toDouble() - 5) * Globals.tileSize,
            tiledLevel.tileMap.map.height.toDouble() * Globals.tileSize));

    add(tiledLevel);
    _addEnemies();
    _addPlayer();
    _addCollisionBlocks();
    _addGomiClones();
    _addCollectibles();
    if (level.hasInfoTiles) _addInfoTiles();

    _setUpCamera();

    scoreNotifier.addListener(_onScoreChange);

    //when health changes check if the player has died (ran out of lives) if so restart the level.
    playerHealth.lives.addListener(() {
      if (playerHealth.isDead) {
        _restartLevel();
      }
    });
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
    router.replace("/play/session/1");
  }

  void _onScoreChange() {}
  @override
  void update(double dt) {
    cameraParallax.speed = player.velocity.x / 2;
    if ((playerCameraAnchor.position - player.position).length2 > 2) {
      playerCameraAnchor.position.setFrom(player.position);
    }
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

  /// Gives the player points
  void addScore({required int amount}) {
    scoreNotifier.value += amount;
  }

  /// Sets the player's score to 0 again.
  void resetScore() {
    scoreNotifier.value = 0;
  }

  void _addCollisionBlocks() {
    final List<Platform> collisionBlocks = [];
    final layer = getTiledLayer(tiledLevel, 'collisions');

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
      collisionBlocks.add(platform);
      add(platform);
    }
    setCollisionBlocks(collisionBlocks);
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
    playerCameraAnchor = PlayerCameraAnchor(
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
