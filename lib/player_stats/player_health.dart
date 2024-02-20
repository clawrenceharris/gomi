import 'package:flutter/foundation.dart';
import 'package:gomi/constants/globals.dart';

class PlayerHealth {
  final ValueNotifier<int> _lives = ValueNotifier<int>(Globals.maxLives);
  ValueNotifier<int> get lives => _lives;
  bool get isDead => lives.value == 0;
  void decrease() {
    _lives.value -= 1;
  }

  void reset() {
    _lives.value = Globals.maxLives;
  }
}
