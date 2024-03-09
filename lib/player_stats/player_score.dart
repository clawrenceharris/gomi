import 'package:flutter/foundation.dart';

class PlayerScore {
  final ValueNotifier<int> _coins = ValueNotifier<int>(0);
  final ValueNotifier<int> _score = ValueNotifier<int>(0);
  final ValueNotifier<int> _totalCoins = ValueNotifier<int>(0);

  ValueNotifier<int> get coins => _coins;
  ValueNotifier<int> get score => _score;
  ValueNotifier<int> get totalCoins => _totalCoins;

  final int bonusMultiplier = 50;
  int _points = 0;
  int get points => _points;
  void addCoin(int points) {
    _points = points;
    _coins.value += 1;
    totalCoins.value += 1;
    _score.value += points;

    if (coins.value == 10) {
      score.value *= bonusMultiplier;
    }
  }

  void addScore(int points) {
    _points = points;
    _score.value += points;
  }

  void reset() {
    _score.value = 0;
    _coins.value = 0;
  }
}
