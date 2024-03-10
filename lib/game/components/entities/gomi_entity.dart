import 'package:flame/components.dart';

mixin GomiEntity on PositionComponent {
  bool gotHit = false;
  late final Vector2 initialPosition;
}
