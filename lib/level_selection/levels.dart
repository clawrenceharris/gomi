const gameLevels = <GameLevel>[
  (number: 1, pathname: 'level-6.tmx', winScore: 0, hasInfoTiles: false),
  (number: 2, pathname: 'level-2.tmx', winScore: 0, hasInfoTiles: false),
  (number: 3, pathname: 'level-3.tmx', winScore: 0, hasInfoTiles: false),
  (number: 4, pathname: 'level-4.tmx', winScore: 0, hasInfoTiles: false),
  (number: 5, pathname: 'level-5.tmx', winScore: 0, hasInfoTiles: false),
  (number: 6, pathname: 'level-6.tmx', winScore: 0, hasInfoTiles: false),
];

typedef GameLevel = ({
  int number,
  String pathname,
  int winScore,
  bool hasInfoTiles
});
