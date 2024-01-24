import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomi/actors/enemy.dart';
import 'package:gomi/constants/globals.dart';

class Level extends World {
  late TiledComponent levelMap;
  @override
  FutureOr<void> onLoad() async {
    levelMap =
        await TiledComponent.load(Globals.lv_1, Vector2.all(Globals.tileSize));

    add(levelMap);

    // Load Enemy Spawn Points Map
    final spawnPointsLayer =
        levelMap.tileMap.getLayer<ObjectGroup>('enemySpawnPoints');
    // Add enemy to each spawn location
    for (final spawnPoint in spawnPointsLayer!.objects) {
      switch (spawnPoint.class_) {
        case 'Enemy':
          final enemy = Enemy(position: Vector2(spawnPoint.x, spawnPoint.y));
          add(enemy);
          break;
        default:
      }
    }

    return super.onLoad();
  }
}
