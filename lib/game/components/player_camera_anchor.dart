import 'package:flame/components.dart';
import 'package:gomi/game/components/entities/player.dart';

class PlayerCameraAnchor extends PositionComponent {
  final double offsetX;
  final double offsetY;
  final Player player;

  PlayerCameraAnchor({
    required this.offsetX,
    required this.offsetY,
    required this.player,
  }) {
    super.size = player.size;
    super.position = player.position;
  }

  @override
  void update(double dt) {
    position =
        Vector2(player.position.x + offsetX, player.position.y + offsetY);
    super.update(dt);
  }
}
