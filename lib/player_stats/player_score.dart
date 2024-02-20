import 'package:flutter/foundation.dart';

class PlayerScore {
  final ValueNotifier<int> _coins = ValueNotifier<int>(0);
  final ValueNotifier<int> _score = ValueNotifier<int>(0);
  final int bonusMultiplier = 100;
  ValueNotifier<int> get coins => _coins;
  ValueNotifier<int> get score => _score;
  int pointsAdded = 0;
  void addCoin(int points) {
    pointsAdded = points;
    _coins.value += 1;

    _score.value += points;
    if (coins.value == 10) {
      score.value *= bonusMultiplier;
    }
  }

  void addScore(int points) {
    pointsAdded = points;

    _score.value += points;
  }

  void reset() {
    _score.value = 0;
    _coins.value = 0;
  }
}
