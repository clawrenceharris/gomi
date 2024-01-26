import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomi/components/actors/bottle_enemy.dart';
import 'package:gomi/components/actors/bulb_enemy.dart';
import 'package:gomi/components/actors/gomi_clone.dart';
import 'package:gomi/components/actors/player.dart';
import 'package:gomi/components/actors/syringe_enemy.dart';
import 'package:gomi/components/collisions/collision_handler.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/components/levels/level_option.dart';

class Level extends World {
  late TiledComponent level;
  final LevelOption levelOption;
  late CollisionHandler collisionHandler;
  late final Player player;
  Level(this.levelOption) : super();

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load(
        levelOption.pathname, Vector2.all(Globals.tileSize));

    add(level);
    _createPlayer();
    _createEnemies();
    _createGomiClones();
    collisionHandler = CollisionHandler(level: level, player: player);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    collisionHandler.checkHorizontalCollisions();
    collisionHandler.checkVerticalCollisions();
    super.update(dt);
  }

  void _createEnemies() {
    // Get the enemies layer
    final ObjectGroup? enemiesLayer = level.tileMap.getLayer('enemies');
    if (enemiesLayer == null) {
      throw Exception("enemies layer not found");
    }

    // Adds each enemy at the TiledObject's position
    for (TiledObject obj in enemiesLayer.objects) {
      switch (obj.class_) {
        case 'Bulb Enemy':
          final enemy = BulbEnemy(position: Vector2(obj.x, obj.y));
          add(enemy);
          break;
        case 'Syringe Enemy':
          final enemy = SyringeEnemy(position: Vector2(obj.x, obj.y));
          add(enemy);
        case 'Bottle Enemy':
          final enemy = BottleEnemy(position: Vector2(obj.x, obj.y));
          add(enemy);
          break;
      }
    }
  }

  //creates the trash bin clones
  void _createGomiClones() {
    final ObjectGroup? actorsLayer = level.tileMap.getLayer("main characters");
    if (actorsLayer == null) {
      throw Exception("main characters layer not found");
    }
    for (final TiledObject obj in actorsLayer.objects) {
      switch (obj.class_) {
        case "Green Gomi":
          final clone = GomiClone(
              character: 'Green Gomi', position: Vector2(obj.x, obj.y));
          add(clone);
          break;

        case "Red Gomi":
          final clone =
              GomiClone(character: 'Red Gomi', position: Vector2(obj.x, obj.y));
          add(clone);
          break;
        case "Blue Gomi":
          final clone = GomiClone(
              character: 'Blue Gomi', position: Vector2(obj.x, obj.y));
          add(clone);
          break;

        case "Black Gomi":
          final clone = GomiClone(
              character: 'Black Gomi', position: Vector2(obj.x, obj.y));
          add(clone);
          break;
      }
    }
  }

  void _createPlayer() {
    final ObjectGroup? actorsLayer = level.tileMap.getLayer("main characters");
    if (actorsLayer == null) {
      throw Exception("main characters layer not found");
    }
    for (final TiledObject obj in actorsLayer.objects) {
      switch (obj.class_) {
        case "Green Player":
          player =
              Player(character: 'Green Gomi', position: Vector2(obj.x, obj.y));
          add(player);
          break;

        case "Red Player":
          player =
              Player(character: 'Red Gomi', position: Vector2(obj.x, obj.y));
          add(player);
          break;
        case "Blue Player":
          player =
              Player(character: 'Blue Gomi', position: Vector2(obj.x, obj.y));
          add(player);
          break;

        case "Black Player":
          final player =
              Player(character: 'Black Gomi', position: Vector2(obj.x, obj.y));
          add(player);
          break;
      }
    }
  }
}
