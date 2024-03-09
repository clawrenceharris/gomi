import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gomi/game/components/powerup.dart';

class PlayerPowerup {
  final ValueNotifier _powerup = ValueNotifier(Powerup.none);
  ValueNotifier get powerup => _powerup;
  final ValueNotifier<List<Powerup>> _powerups =
      ValueNotifier<List<Powerup>>([]);

  bool hasPowerup(Powerup powerup) {
    return _powerups.value.contains(powerup);
  }

  bool isEquipped(Powerup powerup) {
    return _powerup.value == powerup;
  }

  ///sets the currently active powerup
  void equipPowerup(Powerup powerup) {
    _powerup.value = powerup;
  }

  ///adds a power up to the available powerups list
  void addPowerup(Powerup powerup) {
    _powerups.value.add(powerup);
  }

  void reset() {
    powerup.value = Powerup.none;
  }

  void unequipPowerup(Powerup powerup) {
    _powerup.value = Powerup.none;
  }
}
