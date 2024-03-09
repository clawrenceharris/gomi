import 'dart:async';

import 'persistence/local_storage_player_progress_persistence.dart';
import 'package:flutter/foundation.dart';

import 'persistence/player_progress_persistence.dart';

/// Encapsulates the player's progress.
class PlayerProgress extends ChangeNotifier {
  PlayerProgress({PlayerProgressPersistence? store})
      : _store = store ?? LocalStoragePlayerProgressPersistence() {
    getLatestFromStore();
  }

  final PlayerProgressPersistence _store;

  List<int> _levelsFinished = [];

  /// The times for the levels that the player has finished so far.
  List<int> get levels => _levelsFinished;

  /// Fetches the latest data from the backing persistence store.
  Future<void> getLatestFromStore() async {
    final levelsFinished = await _store.getFinishedLevels();
    if (!listEquals(_levelsFinished, levelsFinished)) {
      _levelsFinished = _levelsFinished;
      notifyListeners();
    }
  }

  /// Resets the player's progress so it's like if they just started
  /// playing the game for the first time.
  void reset() {
    _store.reset();
    _levelsFinished.clear();
    notifyListeners();
  }

  /// Registers [level] as reached.
  ///
  /// If this is higher than [highestLevelReached], it will update that
  /// value and save it to the injected persistence store.
  void setLevelFinished(int level, int stars) {
    if (level < _levelsFinished.length - 1) {
      final currentStars = _levelsFinished[level - 1];
      if (stars < currentStars) {
        _levelsFinished[level - 1] = stars;
        notifyListeners();
        unawaited(_store.saveLevelFinished(level, stars));
      }
    } else {
      _levelsFinished.add(stars);
      notifyListeners();
      unawaited(_store.saveLevelFinished(level, stars));
    }
  }
}
