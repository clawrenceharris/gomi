import 'package:flame/camera.dart';
import 'package:flame_tiled/flame_tiled.dart';
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
import 'package:gomi/game/widgets/game_screen.dart';
import 'package:gomi/player_progress/player_progress.dart';
import '../level_selection/levels.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GomiWorld extends World with HasGameReference, HasPlayerRef {
  GomiWorld({
    required this.level,
    required this.playerProgress,
  });

  /// The properties of the current level.
  final GameLevel level;

  late TiledComponent tiledLevel;

  List<CollisionBlock> collisionBlocks = [];

  /// Used to see what the current progress of the player is and to update the
  /// progress if a level is finished.
  final PlayerProgress playerProgress;

  /// The speed is used for determining how fast the background should pass by
  /// and how fast the enemies and obstacles should move.
  // late double speed = _calculateSpeed(level.number);

  /// In the [scoreNotifier] we keep track of what the current score is, and if
  /// other parts of the code is interested in when the score is updated they
  /// can listen to it and act on the updated value.
  final scoreNotifier = ValueNotifier(0);
  late final CameraComponent camera;
  late final DateTime timeStarted;
  Vector2 get size => (parent as FlameGame).size;
  int stars = 0;

  /// The random number generator that is used to spawn periodic components.

  /// The gravity is defined in virtual pixels per second squared.
  /// These pixels are in relation to how big the [FixedResolutionViewport] is.
  final double gravity = 30;

  @override
  Future<void> onLoad() async {
    //initialze the tiled level
    tiledLevel = await TiledComponent.load('level-2.tmx', Vector2.all(16));

    add(tiledLevel);

    _addPlayer();
    _addEnemies();
    _addGomiClones();
    _addCollisionBlocks();
    _addCollectibles();
    camera = CameraComponent(
        world: this, viewport: FixedAspectRatioViewport(aspectRatio: 16 / 9))
      ..viewport.size = size
      ..viewfinder.visibleGameSize = Vector2(400, 500);
    camera.follow(player);

    game.add(camera);

    // When the player takes a new point we check if the score is enough to
    // pass the level and if it is we calculate the stars earned for the level,
    // update the player's progress and open up a dialog that shows that
    // the player passed the level.
    scoreNotifier.addListener(() {
      if (scoreNotifier.value >= level.winScore) {
        //TODO: calculate the amount of stars the player earned for the level
        playerProgress.setLevelFinished(level.number, 0);
        game.pauseEngine();
        game.overlays.add(GameScreen.winDialogKey);
      }
    });
  }

  @override
  void onMount() {
    super.onMount();
    // When the world is mounted in the game we add a back button widget as an
    // overlay so that the player can go back to the previous screen.
    game.overlays.add(GameScreen.backButtonKey);
  }

  @override
  void onRemove() {
    game.overlays.remove(GameScreen.backButtonKey);
  }

  void _addPlayer() {
    final layer = getTiledLayer("player");

    final obj = layer.objects[0];
    final player = Player(
        addScore: addScore,
        resetScore: resetScore,
        character: obj.class_,
        position: Vector2(obj.x, obj.y),
        collisionBlocks: collisionBlocks);
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

  /// [onTapDown] is called when the player taps the screen and then calculates
  /// if and how the player should jump.
  // @override
  // void onTapDown(TapDownEvent event) {
  //   // Which direction the player should jump.
  //   // If the tap is underneath the player no jump is triggered, but if it is
  //   // above the player it triggers a jump, even though the player might be in
  //   // the air. This makes it possible to later implement double jumping inside
  //   // of the `player` class if one would want to.

  //   player.jump(0.5);
  //   super.onTapDown(event);
  // }

  // @override
  // void onTapUp(TapUpEvent event) {
  //   player.hasJumped = false;
  //   super.onTapUp(event);
  // }

  /// A helper function to define how fast a certain level should be.

  void _addCollisionBlocks() {
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
    }
  }

  void _addEnemies() {
    // Get the enemies layer
    final layer = getTiledLayer('enemies');

    // Adds each enemy at the TiledObject's position
    for (final obj in layer.objects) {
      switch (obj.class_) {
        case 'Bulb Enemy':
          final enemy = BulbEnemy(
            position: Vector2(obj.x, obj.y),
          );
          add(enemy);
          break;
        case 'Syringe Enemy':
          final enemy = SyringeEnemy(position: Vector2(obj.x, obj.y));
          add(enemy);
        case 'Bottle Enemy':
          final enemy = BottleEnemy(
              position: Vector2(obj.x, obj.y), attackWidth: obj.width);
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
          final collectible = Seed(
              seed: "Oak",
              position: Vector2(obj.x, obj.y),
              size: Vector2(obj.width, obj.height));
          add(collectible);
          break;
      }
    }
  }
}
