import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

abstract class CollisionBlock extends PositionComponent
    with CollisionCallbacks {
  late final Rect blockRect;
  CollisionBlock({super.position, super.size})
      : super(anchor: Anchor.topCenter) {
    blockRect = Rect.fromPoints(
      Offset(x, y), // Top-left corner
      Offset(x + width, y + height), // Bottom-right corner
    );
  }
}
