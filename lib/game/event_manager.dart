import 'package:flutter/foundation.dart';

class PlayerDeathNotifier extends ChangeNotifier {
  //called when the player dies
  void handlePlayerDeath() {
    // Dispatch the event
    notifyListeners();
  }
}
