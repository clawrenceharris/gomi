import 'package:gomi/components/actors/player.dart';
import 'package:gomi/components/collision%20blocks/collision_block.dart';

class Water extends CollisionBlock {
  Water({position, size}) : super(position: position, size: size);

  @override
  void collideWithPlayer(Player player) {
    if (player.velocity.y > 0) {
      player.velocity.y = 0;
      position.y = y - player.hitbox.height - player.hitbox.offsetY;
      player.isGrounded = true;
    }
  }

  void handleCollision(Player player) {}
}
