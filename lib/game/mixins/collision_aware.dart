import 'package:flame/components.dart';
import 'package:gomi/game/components/collision%20blocks/collision_block.dart';
import 'package:gomi/game/components/collision%20blocks/one_way_platform.dart';

mixin CollisionAware {
  List<CollisionBlock> collisionBlocks = [];
  void setCollisionBlocks(collisionBlocks) {
    this.collisionBlocks = collisionBlocks;
  }

  bool checkCollision(PositionComponent first, PositionComponent second) {
    final fixedY =
        first is OneWayPlatform ? second.y + second.height : second.y;

    return (fixedY < first.y + first.height &&
        second.y + second.height > first.y &&
        second.x < first.x + first.width &&
        second.x + second.width > first.x);
  }
}
