import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gomi/gomi.dart';
import 'package:flame/flame.dart';

void main() {
  //wait for flutter to be initialized
  WidgetsFlutterBinding.ensureInitialized();

  Flame.device.setLandscape();

  Gomi game = Gomi();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false, home: GameWidget(game: game)));
}
