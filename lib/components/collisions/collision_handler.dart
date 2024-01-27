import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomi/components/actors/player.dart';
import 'package:gomi/components/collision%20blocks/collision_block.dart';
import 'package:gomi/components/collision%20blocks/one_way_platform.dart';

class CollisionHandler {
  CollisionHandler({required this.level, required this.player}) {
    addCollisions();
  }
  final TiledComponent level;
  final Player player;

  List<CollisionBlock> collisionBlocks = [];

  void addCollisions() {
    final ObjectGroup? collisionsLayer = level.tileMap.getLayer("collisions");
    if (collisionsLayer == null) {
      throw Exception("collisions layer not found");
    }
    for (final TiledObject obj in collisionsLayer.objects) {
      final platform = CollisionBlock(
          position: Vector2(obj.x, obj.y),
          size: Vector2(obj.width, obj.height));
      collisionBlocks.add(platform);
    }
  }
}
