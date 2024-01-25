import 'package:gomi/constants/globals.dart';

enum LevelOption {
  level_1(Globals.lv_1, "Level 01");

  const LevelOption(this.pathname, this.name);
  final String pathname;
  final String name;
}
