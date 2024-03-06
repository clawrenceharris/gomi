import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/widgets.dart';

class ControlButton extends StatelessWidget {
  const ControlButton(
      {required this.image, super.key, this.onTapUp, this.onTapDown});
  final Function(TapUpDetails details)? onTapUp;
  final Function(TapDownDetails details)? onTapDown;
  final String image;
  Future<Sprite> getSprite() async {
    var image = Flame.images.fromCache(this.image);
    return Sprite(image);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        child: Transform.scale(
          scale: 3.0, // Adjust the scale factor as needed
          child: Image.asset(image, width: 90, height: 50),
        ));
  }
}
