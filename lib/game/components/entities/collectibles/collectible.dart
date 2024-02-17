import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'package:gomi/game/gomi_level.dart';

class Collectible extends SpriteAnimationComponent
    with CollisionCallbacks, HasWorldReference<GomiLevel> {
  late final Vector2 startingPosition;
  Collectible(
      {required super.position, super.anchor, super.size, super.animation});
  @override
  FutureOr<void> onLoad() {
    startingPosition = Vector2(position.x, position.y);
    return super.onLoad();
  }

  void collideWithPlayer() {
    removeFromParent();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      collideWithPlayer();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  void respawn() {
    position = Vector2(startingPosition.x, startingPosition.y);
  }
}
