import 'package:flame/components.dart';
import 'package:gomi/game/components/collisions/platforms/one_way_platform.dart';
import 'package:gomi/game/components/collisions/platforms/platform.dart';
import 'package:gomi/game/components/entities/enemies/enemy.dart';
import 'package:gomi/game/components/entities/player.dart';

mixin CollisionAware {
  List<Platform> platforms = [];
  final double topCollisionPaddingHeight = 7;
  void setCollisionBlocks(platforms) {
    this.platforms = platforms;
  }

  bool checkCollision(
    PositionComponent other,
    Platform platform,
  ) {
    final fixedX = other.scale.x < 0 ? other.x - other.width : other.x;
    final fixedY =
        platform is OneWayPlatform ? other.y + other.height : other.y;

    return (fixedY < platform.y + platform.height &&
        other.y + other.height > platform.y &&
        fixedX < platform.x + platform.width &&
        fixedX + other.width > platform.x);
  }

  bool isCollisionFromTopPlayer(Player other, PositionComponent platform) {
    return other.y + other.height <= platform.y &&
        other.y + other.height >= platform.y - topCollisionPaddingHeight &&
        other.x >= platform.x &&
        other.x <= platform.x + platform.width;
  }

  bool isCollisionFromTopEnemy(Enemy other, PositionComponent platform) {
    return other.y + other.height <= platform.y &&
        other.y + other.height >= platform.y - topCollisionPaddingHeight &&
        other.x >= platform.x &&
        other.x <= platform.x + platform.width;
  }

  bool checkCollisionTopCenter(PositionComponent other, Platform platform) {
    final topCenterX = other.scale.x > 0
        ? other.x - (other.width / 2)
        : other.x + other.width / 2;
    final topCenterY = other.y;

    final fixedX = other.scale.x < 0 ? topCenterX - other.width : topCenterX;
    final fixedY =
        platform is OneWayPlatform ? topCenterY + other.height : topCenterY;
    return (fixedY < platform.y + platform.height &&
        fixedY + other.height > platform.y &&
        fixedX < platform.x + platform.width &&
        fixedX + other.width > platform.x);
  }
}
