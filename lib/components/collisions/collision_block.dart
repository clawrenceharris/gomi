import 'package:flame/components.dart';

class CollisionBlock extends PositionComponent {
  bool isPlatform;
  bool isHazard;
  CollisionBlock(
      {position, size, this.isPlatform = false, this.isHazard = false})
      : super(position: position, size: size) {
    debugMode = true;
  }
}
