import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/components/actors/player.dart';

abstract class CollisionBlock extends PositionComponent
    with CollisionCallbacks {
  CollisionBlock({position, size}) : super(position: position, size: size);

  void onPlayerCollision(Player player);
}
