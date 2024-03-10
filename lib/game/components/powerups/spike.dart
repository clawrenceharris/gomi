import 'dart:async';

import 'package:flame/collisions.dart';

import 'package:gomi/game/components/powerups/powerup.dart';

class Spike extends Powerup {
  Spike({super.position});
  late final _coins = 30;

  @override
  int get coins => _coins;

  late final _name = "The Spike Surge";

  @override
  String get name => _name;

  late final _description =
      "Fend off Litter Critters by tossing\nspikes in the air.\nPress space to activate";

  @override
  String get description => _description;

  late final _image = "assets/images/powerups/spike.png";

  @override
  String get image => _image;

  @override
  FutureOr<void> onLoad() async {
    add(RectangleHitbox(collisionType: CollisionType.passive));

    return super.onLoad();
  }
}
