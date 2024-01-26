import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomi/components/collisions/collision_block.dart';

class CollisionHandler {
  CollisionHandler({required this.level});
  final TiledComponent level;
  List<CollisionBlock> collisionBlocks = [];

  void addCollisions() {
    final ObjectGroup? collisionsLayer = level.tileMap.getLayer("platforms");
    if (collisionsLayer == null) {
      throw Exception("platforms layer not found");
    }
    for (final TiledObject obj in collisionsLayer.objects) {
      switch (obj.class_) {
        case 'Platform':
          final platform = CollisionBlock(
              position: Vector2(obj.x, obj.y),
              size: Vector2(obj.width, obj.height));
          collisionBlocks.add(platform);
      }
    }
  }
}
