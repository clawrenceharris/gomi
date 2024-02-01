import 'package:flame/components.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/gomi_game.dart';

enum PlayerState {
  idle,
  running,
}

class GomiClone extends SpriteAnimationComponent with HasGameRef<Gomi> {
  GomiClone({
    required this.character,
    super.position,
  }) : super(animation: AnimationConfigs.gomi.idle(character));
  String character;
}
