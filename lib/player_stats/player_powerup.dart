import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gomi/game/components/powerups/grabber.dart';
import 'package:gomi/game/components/powerups/powerup.dart';
import 'package:gomi/game/components/powerups/spike.dart';

class PlayerPowerups {
  final ValueNotifier<Powerup?> _powerupNotifier =
      ValueNotifier<Powerup?>(null);
  ValueNotifier<Powerup?> get powerupNotifier => _powerupNotifier;
  Powerup? get powerup => _powerupNotifier.value;
  static List<Powerup> get allPowerups => [Grabber(), Spike()];
  final ValueNotifier<List<Powerup>> _powerups =
      ValueNotifier<List<Powerup>>([]);

  bool hasPowerup(Powerup powerup) {
    return _powerups.value.contains(powerup);
  }

  bool isEquipped(Powerup powerup) {
    return _powerupNotifier.value == powerup;
  }

  ///sets the currently active powerup
  void equipPowerup(Powerup powerup) {
    _powerupNotifier.value = powerup;
  }

  ///adds a power up to the available powerups list
  void addPowerup(Powerup powerup) {
    _powerups.value.add(powerup);
  }

  void reset() {
    powerupNotifier.value = null;
  }
}
