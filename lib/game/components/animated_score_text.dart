import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class AnimatedScoreText extends PositionComponent {
  final String text;
  double _elapsedTime = 0.0;
  final double _activeTime = 0.5;
  AnimatedScoreText({required this.text, super.position});
  @override
  FutureOr<void> onLoad() {
    add(TextComponent(
        text: text,
        textRenderer: TextPaint(
            style: const TextStyle(
                color: Colors.yellow, fontFamily: 'Pixel', fontSize: 7))));
    add(MoveEffect.to(Vector2(position.x, position.y - 10),
        EffectController(duration: 0.6, infinite: false)));
    //add(OpacityEffect.to(1, EffectController(duration: 2, infinite: false)));

    return super.onLoad();
  }

  @override
  void update(double dt) {
    _elapsedTime += dt;
    if (_elapsedTime >= _activeTime) {
      _elapsedTime = 0.0;

      removeFromParent();
    }
    super.update(dt);
  }
}
