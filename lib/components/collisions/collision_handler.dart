import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomi/components/actors/player.dart';
import 'package:gomi/components/collisions/collision_block.dart';

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

  void checkHorizontalCollisions() {
    for (CollisionBlock block in collisionBlocks) {
      if (!block.isPlatform) {
        if (checkCollision(block)) {
          if (player.velocity.x > 0) {
            player.velocity.x = 0;
            player.position.x = block.x - player.width;
            break;
          }
          if (player.velocity.x < 0) {
            player.velocity.x = 0;
            player.position.x = block.x + player.width;
            break;
          }
        }
      }
    }
  }

  void checkVerticalCollisions() {
    for (CollisionBlock block in collisionBlocks) {
      if (block.isPlatform) {
        if (checkCollision(block)) {
          if (player.velocity.y > 0) {
            player.velocity.y = 0;
            player.position.y = block.y - player.width;
            player.isOnGround = true;
            break;
          }
          if (player.velocity.y < 0) {
            player.velocity.y = 0;
            player.position.y = block.y + block.height;
            break;
          }
        }
      } else {
        if (checkCollision(block)) {
          if (player.velocity.y > 0) {
            player.velocity.y = 0;
            player.position.y = block.y - player.width;
            player.isOnGround = true;
            break;
          }
          if (player.velocity.y < 0) {
            player.velocity.y = 0;
            player.position.y = block.y + block.height;
            break;
          }
        }
      }
    }
  }

  bool checkCollision(CollisionBlock block) {
    final playerX = player.position.x;
    final playerY = player.position.y;
    final playerHeight = player.height;
    final playerWidth = player.width;

    final blockX = block.x;
    final blockY = block.y;
    final blockWidth = block.width;
    final blockHeight = block.height;
    final fixedX = player.scale.x < 0 ? playerX - playerWidth : playerX;
    final fixedY = block.isPlatform ? playerY + playerHeight : playerY;

    return (fixedY < block.y + blockHeight &&
        playerY + playerHeight > blockY &&
        fixedX < blockX + blockWidth &&
        fixedX + playerWidth > block.x);
  }
}
