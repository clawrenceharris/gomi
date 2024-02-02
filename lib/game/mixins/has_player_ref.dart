import 'package:gomi/game/components/entities/player.dart';

mixin HasPlayerRef {
  late final Player player;
  setPlayer(Player player) {
    this.player = player;
  }
}
