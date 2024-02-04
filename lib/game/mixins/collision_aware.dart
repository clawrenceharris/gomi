import 'package:flame/components.dart';
import 'package:gomi/game/components/collision%20blocks/collision_block.dart';
import 'package:gomi/game/components/collision%20blocks/one_way_platform.dart';

mixin CollisionAware {
  List<CollisionBlock> collisionBlocks = [];
  void setCollisionBlocks(collisionBlocks) {
    this.collisionBlocks = collisionBlocks;
  }

  bool checkCollision(CollisionBlock block, PositionComponent other) {
    final fixedX = other.scale.x < 0 ? other.x - other.width : other.x;
    final fixedY = block is OneWayPlatform ? other.y + other.height : other.y;

    return (fixedY < block.y + block.height &&
        other.y + other.height > block.y &&
        fixedX < block.x + block.width &&
        fixedX + other.width > block.x);
  }

  bool checkCollisionTopCenter(PositionComponent other, CollisionBlock block) {
    final topCenterX = other.scale.x > 0
        ? other.x - (other.width / 2)
        : other.x + other.width / 2;
    final topCenterY = other.y;

    final fixedX = other.scale.x < 0 ? topCenterX - other.width : topCenterX;
    final fixedY =
        block is OneWayPlatform ? topCenterY + other.height : topCenterY;

    return (fixedY < block.y + block.height &&
        fixedY + other.height > block.y &&
        fixedX < block.x + block.width &&
        fixedX + other.width > block.x);
  }
}
