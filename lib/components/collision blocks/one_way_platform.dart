import 'package:gomi/components/actors/player.dart';
import 'package:gomi/components/collision%20blocks/collision_block.dart';

class OneWayPlatform extends CollisionBlock {
  OneWayPlatform({position, size}) : super(position: position, size: size);

  @override
  void onPlayerCollision(Player player) {
    handleVerticalCollision(player);
  }

  void handleVerticalCollision(Player player) {
    if (player.velocity.y > 0) {
      player.velocity.y = 0;
      position.y = y - player.hitbox.height - player.hitbox.offsetY;
      player.isGrounded = true;
    }
  }
}
