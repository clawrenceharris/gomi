const gameLevels = <GameLevel>[
  (number: 1, pathname: 'level-1.tmx', winScore: 0, hasInfoTiles: true),
  (number: 2, pathname: 'level-2.tmx', winScore: 0, hasInfoTiles: false),
  (number: 3, pathname: 'level-3.tmx', winScore: 0, hasInfoTiles: false),
];

typedef GameLevel = ({
  int number,
  String pathname,
  int winScore,
  bool hasInfoTiles
});
