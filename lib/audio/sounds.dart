List<String> soundTypeToFilename(SfxType type) {
  switch (type) {
    case SfxType.jump:
      return const [
        'jump1.mp3',
      ];
    case SfxType.doubleJump:
      return const [
        'double_jump1.mp3',
      ];
    case SfxType.hit:
      return const [
        'hit1.mp3',
        'hit2.mp3',
      ];
    case SfxType.damage:
      return const [
        'damage1.mp3',
        'damage2.mp3',
      ];
    case SfxType.score:
      return const [
        'score1.mp3',
        'score2.mp3',
      ];
    case SfxType.buttonTap:
      return const [
        'click1.mp3',
        'click2.mp3',
        'click3.mp3',
        'click4.mp3',
      ];
    case SfxType.coin:
      return const ['pickup-coin.mp3'];
    case SfxType.seed:
      return const ['level_complete.mp3'];
    case SfxType.death:
      return const ['death.mp3'];

    case SfxType.plasticEnemy:
      return const ['crunch.mp3'];
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
    case SfxType.score:
    case SfxType.death:
    case SfxType.coin:
      return 1.0;
    case SfxType.seed:
      return 1.0;
    case SfxType.jump:
      return 0.5;
    case SfxType.doubleJump:
      return 0.5;
    case SfxType.damage:
    case SfxType.gomiClone:
    case SfxType.plasticEnemy:
      return 1.0;
    case SfxType.glassEnemy:
      return 1.0;
    case SfxType.biohazardEnemy:
      return 1.0;
    case SfxType.compostEnemy:
      return 1.0;
    case SfxType.hit:
      return 0.4;
    case SfxType.buttonTap:
      return 1.0;
  }
}

enum SfxType {
  score,
  death,
  jump,
  doubleJump,
  gomiClone,
  coin,
  seed,
  hit,
  damage,
  buttonTap,
  plasticEnemy,
  biohazardEnemy,
  compostEnemy,
  glassEnemy,
}
