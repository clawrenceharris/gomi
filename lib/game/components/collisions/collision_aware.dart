import 'package:gomi/game/components/collisions/platforms/one_way_platform.dart';
import 'package:gomi/game/components/collisions/platforms/platform.dart';
import 'package:gomi/game/components/entities/gomi_entity.dart';

mixin CollisionAware {
  List<Platform> platforms = [];
  void setPlatforms(platforms) {
    this.platforms = platforms;
  }

  void checkHorizontalCollisions(
      GomiEntity other, Iterable<Platform> platforms) {
    for (final platform in platforms) {
      if (checkCollisionTopCenter(other, platform)) {
        platform.resolveCollisionFromLeft(other);
        platform.resolveCollisionFromRight(other);
      }
    }
  }

  void checkVerticalCollisions(GomiEntity other, Iterable<Platform> platforms) {
    for (final platform in platforms) {
      if (checkCollisionTopCenter(other, platform)) {
        platform.resolveCollisionFromTop(other);
        platform.resolveCollisionFromBottom(other);
      }
    }
  }

  ///checks collision from all sides based on top center anchor
  bool checkCollisionTopCenter(GomiEntity other, Platform platform) {
    final topCenterX = other.scale.x > 0
        ? other.position.x - (other.width / 2)
        : other.position.x + other.width / 2;
    final topCenterY = other.y;

    //the x dependent on the scale of the player
    final fixedX = other.scale.x < 0 ? topCenterX - other.width : topCenterX;

    //the y adjusted for the case of one way platform
    final fixedY =
        platform is OneWayPlatform ? topCenterY + other.height : topCenterY;

    return (fixedY < platform.position.y + platform.height &&
        topCenterY + other.height > platform.position.y &&
        fixedX < platform.x + platform.width &&
        fixedX + other.width > platform.position.x);
  }
}
