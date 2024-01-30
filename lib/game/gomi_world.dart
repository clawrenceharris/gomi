import 'dart:async';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomi/game/components/entities/enemies/bottle_enemy.dart';
import 'package:gomi/game/components/entities/enemies/bulb_enemy.dart';
import 'package:gomi/game/components/entities/collectibles/gomi_clone.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'package:gomi/game/components/entities/collectibles/seed.dart';
import 'package:gomi/game/components/entities/enemies/syringe_enemy.dart';
import 'package:gomi/game/components/entities/enemies/tomato_enemy.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/game/components/collision%20blocks/collision_block.dart';
import 'package:gomi/game/components/collision%20blocks/normal_platform.dart';
import 'package:gomi/game/components/collision%20blocks/one_way_platform.dart';
import 'package:gomi/game/components/collision%20blocks/water.dart';

class GomiWorld extends World with HasGameRef {
  late TiledComponent level;
  late final Player _player;
  GomiWorld() : super();
  final List<CollisionBlock> collisionBlocks = [];

  @override
  FutureOr<void> onLoad() async {
    level =
        await TiledComponent.load("level-2.tmx", Vector2.all(Globals.tileSize));
    add(level);
    _createEnemies();
    _createGomiClones();
    _addCollisionBlocks();
    _spawnCollectibles();
    _createPlayer();
    gameRef.camera = CameraComponent(
      viewport: FixedAspectRatioViewport(aspectRatio: 1.0),
      world: this,
    )
      ..viewfinder.anchor = Anchor.center
      ..viewport.size = gameRef.size
      ..viewfinder.visibleGameSize = Vector2(300, 300);
    gameRef.camera.follow(_player, snap: true);
    return super.onLoad();
  }

  void _addCollisionBlocks() {
    final collisionsLayer = level.tileMap.getLayer<ObjectGroup>('collisions');
    if (collisionsLayer == null) {
      throw Exception("collisions layer not found");
    }
    for (TiledObject collision in collisionsLayer.objects) {
      switch (collision.class_) {
        case "One Way Platform":
          final platform = OneWayPlatform(
            position: Vector2(collision.x, collision.y),
            size: Vector2(collision.width, collision.height),
          );
          add(platform);
          collisionBlocks.add(platform);

        case "Water":
          final platform = Water(
            position: Vector2(collision.x, collision.y),
            size: Vector2(collision.width, collision.height),
          );
          add(platform);
          collisionBlocks.add(platform);

        default:
          final platform = NormalPlatform(
            position: Vector2(collision.x, collision.y),
            size: Vector2(collision.width, collision.height),
          );
          add(platform);
          collisionBlocks.add(platform);
      }
    }
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
        case 'Tomato Enemy':
          final enemy = TomatoEnemy(
              position: Vector2(obj.x, obj.y), attackHeight: obj.height);
          add(enemy);
          break;
        default:
          break;
      }
    }
  }

  //creates the trash bin clones
  void _createGomiClones() {
    final ObjectGroup? charactersLayer = level.tileMap.getLayer("gomi clones");
    if (charactersLayer != null) {
      for (final TiledObject obj in charactersLayer.objects) {
        switch (obj.class_) {
          case "Green Gomi":
            final clone = GomiClone(
                character: 'Green Gomi', position: Vector2(obj.x, obj.y));
            add(clone);
            break;

          case "Red Gomi":
            final clone = GomiClone(
                character: 'Red Gomi', position: Vector2(obj.x, obj.y));
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
  }

  void _createPlayer() {
    final ObjectGroup? charactersLayer = level.tileMap.getLayer("player");

    if (charactersLayer != null) {
      for (final TiledObject obj in charactersLayer.objects) {
        switch (obj.class_) {
          case "Green Gomi":
            _player = Player(
                character: 'Green Gomi',
                position: Vector2(obj.x, obj.y),
                collisionBlocks: collisionBlocks);
            add(_player);
            break;

          case "Red Gomi":
            _player = Player(
                character: 'Red Gomi',
                position: Vector2(obj.x, obj.y),
                collisionBlocks: collisionBlocks);
            add(_player);
            break;
          case "Blue Player":
            _player = Player(
                character: 'Blue Gomi',
                position: Vector2(obj.x, obj.y),
                collisionBlocks: collisionBlocks);
            add(_player);
            break;

          case "Black Player":
            final player = Player(
                character: 'Black Gomi',
                position: Vector2(obj.x, obj.y),
                collisionBlocks: collisionBlocks);
            add(player);
            break;
        }
      }
    }
  }

  void _spawnCollectibles() {
    final ObjectGroup? collectiblesLayer =
        level.tileMap.getLayer("collectibles");
    if (collectiblesLayer == null) {
      throw Exception("collectibles layer not found");
    }

    for (final collectible in collectiblesLayer.objects) {
      switch (collectible.class_) {
        case 'Seed':
          final seed = Seed(
              position: Vector2(collectible.x, collectible.y),
              size: Vector2(collectible.width, collectible.height));
          add(seed);
          break;
      }
    }
  }
}
