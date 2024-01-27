import 'package:gomi/components/actors/player.dart';
import 'package:gomi/components/collision%20blocks/collision_block.dart';

class NormalPlatform extends CollisionBlock {
  NormalPlatform({position, size}) : super(position: position, size: size);

  @override
  void onPlayerCollision(Player player) {
    handleVerticalCollision(player);
    handleHorizontalCollision(player);
  }

  void handleVerticalCollision(Player player) {
    if (player.velocity.y > 0) {
      player.velocity.y = 0;
      position.y = y - player.hitbox.height - player.hitbox.offsetY;
      player.isGrounded = true;
    } else if (player.velocity.y < 0) {
      player.velocity.y = 0;
      position.y = y + height - player.hitbox.offsetY;
    }
  }

  void handleHorizontalCollision(Player player) {
    if (player.velocity.x > 0) {
      player.velocity.x = 0;
      position.x = x - player.hitbox.offsetX - player.hitbox.width;
    } else if (player.velocity.x < 0) {
      player.velocity.x = 0;
      position.x = x + width + player.hitbox.width + player.hitbox.offsetX;
    }
  }
}
