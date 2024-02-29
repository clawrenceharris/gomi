List<String> soundTypeToFilename(SfxType type) {
  switch (type) {
    case SfxType.jump:
      return const [
        'jump.mp3',
      ];
    case SfxType.doubleJump:
      return const [
        'jump.mp3',
      ];
    case SfxType.hit:
      return const [
        'hit.mp3',
      ];
    case SfxType.buttonTap:
      return const [
        'click.mp3',
      ];
    case SfxType.coin:
      return const ['coin.mp3'];
    case SfxType.seed:
      return const ['level_complete.mp3'];
    case SfxType.death:
      return const ['death.mp3'];

    case SfxType.plasticEnemy:
      return const ['plastic.mp3'];
    case SfxType.glassEnemy:
      return const ['shatter.mp3'];
    case SfxType.biohazardEnemy:
      return const ['twang.mp3'];
    case SfxType.compostEnemy:
      return const ['splat.mp3'];
    case SfxType.gomiClone:
      return const [
        'equip.mp3',
      ];
  }
}

/// Allows control over loudness of different SFX types.
double soundTypeToVolume(SfxType type) {
  switch (type) {
    case SfxType.death:
    case SfxType.coin:
    case SfxType.gomiClone:
    case SfxType.plasticEnemy:
    case SfxType.glassEnemy:
    case SfxType.biohazardEnemy:
    case SfxType.compostEnemy:
    case SfxType.buttonTap:
    case SfxType.seed:
    case SfxType.hit:
      return 1.0;
    case SfxType.jump:
    case SfxType.doubleJump:
      return 0.5;
    default:
      return 0;
  }
}

enum SfxType {
  death,
  jump,
  doubleJump,
  gomiClone,
  coin,
  seed,
  hit,
  buttonTap,
  plasticEnemy,
  biohazardEnemy,
  compostEnemy,
  glassEnemy,
}
