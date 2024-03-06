import 'dart:io';

import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/foundation.dart';

ObjectGroup getTiledLayer(TiledComponent tiledLevel, String name) {
  //gets the tile layer by a given name and returns it or throws exception if not found

  final ObjectGroup? layer = tiledLevel.tileMap.getLayer(name.toLowerCase());

  if (layer == null) {
    throw Exception("The layer $name could not be found.");
  }
  return layer;
}

dynamic getTiledPropertyValue(TiledObject tiledObject, String name) {
  final value = tiledObject.properties.getValue(name);
  if (value == null) {
    throw Exception(
        "property $name not found. Check spelling and that the property exists in Tiled.");
  }
}

bool isMobile() {
  return !kIsWeb && (Platform.isIOS || Platform.isAndroid);
}
