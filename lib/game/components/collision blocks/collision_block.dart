import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

abstract class CollisionBlock extends PositionComponent
    with CollisionCallbacks {
  CollisionBlock({position, size}) : super(position: position, size: size);
}
