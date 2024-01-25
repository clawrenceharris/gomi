import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomi/actors/bulb_enemy.dart';
import 'package:gomi/actors/player.dart';
import 'package:gomi/actors/syringe_enemy.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/levels/level_option.dart';

class Level extends World {
  late TiledComponent level;
  final LevelOption levelOption;

  Player player = Player(character: 'Green Gomi');
  Level(this.levelOption) : super();

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load(
        levelOption.pathname, Vector2.all(Globals.tileSize));

    add(level);

    _createMainCharacters();
    _createEnemies();
    return super.onLoad();
  }

  void _createEnemies() {
    // Get the enemies layer
    ObjectGroup? enemiesLayer = level.tileMap.getLayer('enemies');
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
          break;
      }
    }
  }

  //creates the trash bin characters
  void _createMainCharacters() {
    ObjectGroup? actorsLayer = level.tileMap.getLayer("main characters");
    if (actorsLayer == null) {
      throw Exception("main characters Layer not found");
    }
    for (final TiledObject obj in actorsLayer.objects) {
      switch (obj.class_) {
        case "Green Gomi":
          player =
              Player(character: 'Green Gomi', position: Vector2(obj.x, obj.y));
          add(player);
          break;

        case "Red Gomi":
          player =
              Player(character: 'Red Gomi', position: Vector2(obj.x, obj.y));
          add(player);
          break;
        case "Blue Gomi":
          player =
              Player(character: 'Blue Gomi', position: Vector2(obj.x, obj.y));
          add(player);
          break;

        case "Black Gomi":
          player =
              Player(character: 'Black Gomi', position: Vector2(obj.x, obj.y));
          add(player);
          break;
      }
    }
  }
}
