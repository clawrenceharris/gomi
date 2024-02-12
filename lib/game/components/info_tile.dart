import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:gomi/game/components/entities/player.dart';
import 'package:flame/components.dart';
import 'package:gomi/game/gomi_world.dart';

class InfoTile extends PositionComponent
    with CollisionCallbacks, HasWorldReference<GomiWorld> {
  final int index;
  late final SpriteComponent infoSprite;
  InfoTile({required this.index, super.position, super.size});

  @override
  FutureOr<void> onLoad() async {
    add(RectangleHitbox(collisionType: CollisionType.passive));

    final image =
        await Flame.images.load('tutorials/tutorial_${index + 1}.png');

    double aspectRatio = image.width / image.height;
    double width = 70;
    infoSprite = SpriteComponent(
        sprite: Sprite(image),
        size: Vector2(width, width / aspectRatio),
        position:
            Vector2(position.x - width / 2 + this.width / 2, position.y - 50));
    return super.onLoad();
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    infoSprite.removeFromParent();

    super.onCollisionEnd(other);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) async {
    if (other is Player) {
      world.add(infoSprite);
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
