import 'package:flame/components.dart';

mixin GomiEntity on PositionComponent {
  late final double speed;
  bool gotHit = false;
  late final Vector2 initialPosition;
}
