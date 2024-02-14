import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

class ParallaxBackground extends ParallaxComponent {
  ParallaxBackground({required this.speed, this.layers});
  final dynamic layers;
  double speed;

  @override
  Future<void> onLoad() async {
    parallax = await game.loadParallax(
      layers,
      baseVelocity: Vector2(0, 0),
      velocityMultiplierDelta: Vector2(2.5, 0.0),
      filterQuality: FilterQuality.none,
    );
  }

  @override
  void update(double dt) {
    parallax?.baseVelocity = Vector2(speed / pow(2, layers.length), 0);
    super.update(dt);
  }
}
