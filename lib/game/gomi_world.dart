import 'package:flame/camera.dart';
import 'package:flame/events.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/game/components/entities/enemies/tomato_enemy.dart';
import 'package:gomi/game/components/parallax_background.dart';
import 'package:gomi/game/components/entities/enemies/bottle_enemy.dart';
import 'package:gomi/game/components/entities/enemies/syringe_enemy.dart';
import 'package:gomi/game/components/collision%20blocks/collision_block.dart';
import 'package:gomi/game/components/collision%20blocks/normal_platform.dart';
import 'package:gomi/game/components/collision%20blocks/one_way_platform.dart';
import 'package:gomi/game/components/collision%20blocks/water.dart';
import 'package:gomi/game/components/entities/collectibles/gomi_clone.dart';
import 'package:gomi/game/components/entities/collectibles/seed.dart';
import 'package:gomi/game/components/entities/enemies/bulb_enemy.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'package:gomi/game/components/player_camera_anchor.dart';
import 'package:gomi/game/mixins/collision_aware.dart';
import 'package:gomi/game/mixins/has_player_ref.dart';
import 'package:gomi/player_progress/player_progress.dart';
import '../level_selection/levels.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GomiWorld extends World
    with HasGameReference, HasPlayerRef, TapCallbacks, CollisionAware {
  GomiWorld({
    required this.level,
    required this.playerProgress,
  });

  final GameLevel level;
  late TiledComponent tiledLevel;
  // Used to see what the current progress of the player is and to update the
  // progress if a level is finished.
  final PlayerProgress playerProgress;

  /// In the [scoreNotifier] we keep track of what the current score is, and if
  /// other parts of the code is interested in when the score is updated they
  /// can listen to it and act on the updated value.
  final scoreNotifier = ValueNotifier(0);
  late final CameraComponent camera;
  late final DateTime timeStarted;
  Vector2 get size => (parent as FlameGame).size;
  late final _cameraTarget; // Create a dummy component.

  //the stars earned for the level
  int stars = 0;

  final cameraParallax = ParallaxBackground(speed: 0);
  @override
  Future<void> onLoad() async {
    //load the tiled level
    tiledLevel = await TiledComponent.load(
        level.pathname, Vector2.all(Globals.tileSize));

    add(tiledLevel);

    _addCollisionBlocks();
    _addPlayer();
    _addEnemies();
    _addGomiClones();
    _addCollectibles();

    _setUpCamera();

    // When the player takes a new point we check if the score is enough to
    // pass the level and if it is we calculate the stars earned for the level,
    // update the player's progress and open up a dialog that shows that
    // the player passed the level.
    scoreNotifier.addListener(() {
      if (scoreNotifier.value >= level.winScore) {
        //TODO: calculate the amount of stars the player earned for the level
        playerProgress.setLevelFinished(level.number, stars);
        game.pauseEngine();
      }
    });
  }

  @override
  void update(double dt) {
    cameraParallax.speed = player.velocity.x / 2;
    if ((_cameraTarget.position - player.position).length2 > 2) {
      _cameraTarget.position.setFrom(player.position);
    }
    super.update(dt);
  }

  @override
  void onMount() {
    super.onMount();
    // When the world is mounted in the game add a back button widget as an overlay
  }

  @override
  void onRemove() {}

  void _addPlayer() {
    final layer = getTiledLayer("player");

    //there can only be one player in the level so get the first and only one
    final obj = layer.objects[0];
    final player = Player(
        addScore: addScore,
        resetScore: resetScore,
        color: obj.properties.getValue("Color").toString().trim(),
        position: Vector2(obj.x, obj.y));
    add(player);
    setPlayer(player);
  }

  /// Gives the player points, with a default value +1 points.
  void addScore({int amount = 1}) {
    scoreNotifier.value += amount;
  }

  /// Sets the player's score to 0 again.
  void resetScore() {
    scoreNotifier.value = 0;
  }

  void _addCollisionBlocks() {
    final List<CollisionBlock> collisionBlocks = [];
    final layer = getTiledLayer('collisions');

    for (final collision in layer.objects) {
      switch (collision.class_) {
        case "One Way Platform":
          final platform = OneWayPlatform(
            position: Vector2(collision.x, collision.y),
            size: Vector2(collision.width, collision.height),
          );
          collisionBlocks.add(platform);
          add(platform);
        case "Water":
          final platform = Water(
            position: Vector2(collision.x, collision.y),
            size: Vector2(collision.width, collision.height),
          );
          collisionBlocks.add(platform);
          add(platform);

        default:
          final platform = NormalPlatform(
            position: Vector2(collision.x, collision.y),
            size: Vector2(collision.width, collision.height),
          );
          collisionBlocks.add(platform);
          add(platform);
      }
      setCollisionBlocks(collisionBlocks);
    }
  }

  void _addEnemies() {
    // Get the enemies layer
    final layer = getTiledLayer('enemies');

    // Adds each enemy at the TiledObject's position
    for (final obj in layer.objects) {
      switch (obj.class_) {
        case 'Bulb Enemy':
          final direction = obj.properties.getValue("Direction");
          final enemy = BulbEnemy(
            player: player,
            position: Vector2(obj.x, obj.y),
            direction: direction,
          );
          add(enemy);
          break;
        case 'Syringe Enemy':
          final offNeg = obj.properties.getValue("offNeg");
          final offPos = obj.properties.getValue("offPos");

          final enemy = SyringeEnemy(
              position: Vector2(obj.x, obj.y),
              player: player,
              offNeg: offNeg,
              offPos: offPos);
          add(enemy);
        case 'Bottle Enemy':
          final offNeg = obj.properties.getValue("Off Neg");
          final offPos = obj.properties.getValue("Off Pos");
          final enemy = BottleEnemy(
            player: player,
            offNeg: offNeg,
            offPos: offPos,
            position: Vector2(obj.x, obj.y),
          );
          add(enemy);
          break;
        case 'Tomato Enemy':
          final jumpForce = obj.properties.getValue("Jump Force");
          final enemy = TomatoEnemy(
              jumpForce: jumpForce,
              player: player,
              position: Vector2(obj.x, obj.y));
          add(enemy);
          break;
      }
    }
  }

  //creates the trash bin clones
  void _addGomiClones() {
    final layer = getTiledLayer("gomi clones");
    for (final TiledObject obj in layer.objects) {
      final clone =
          GomiClone(character: obj.class_, position: Vector2(obj.x, obj.y));
      add(clone);
    }
  }

  ObjectGroup getTiledLayer(String name) {
    //gets the tile layer by a given name and returns it or throws exception if not found

    final ObjectGroup? layer = tiledLevel.tileMap.getLayer(name);

    if (layer == null) {
      throw Exception("The layer $name could not be found.");
    }
    return layer;
  }

  void _addCollectibles() {
    final layer = getTiledLayer("collectibles");

    for (final obj in layer.objects) {
      switch (obj.class_) {
        case 'Seed':
          final collectible =
              Seed(seed: "Seed", position: Vector2(obj.x, obj.y));
          add(collectible);
          break;
      }
    }
  }

  void _setUpCamera() {
    game.camera = CameraComponent(
        world: this, viewport: FixedAspectRatioViewport(aspectRatio: 16 / 10))
      ..viewport.size = size
      ..viewfinder.anchor = Anchor.center
      ..viewfinder.visibleGameSize = Vector2(150, 350);
    _cameraTarget =
        PlayerCameraAnchor(offsetX: 80, offsetY: -50, player: player);
    add(_cameraTarget); // Add the dummy component to the scene.
    //anchor that will be used to follow the player at a given offset x and y
    // PlayerCameraAnchor anchor =
    //     PlayerCameraAnchor(player: player, offsetX: 80, offsetY: -50);
    game.camera.follow(_cameraTarget, maxSpeed: 600, snap: true);
    game.camera.backdrop.add(cameraParallax);
  }
}
