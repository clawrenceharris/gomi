const gameLevels = <GameLevel>[
  (number: 1, pathname: 'level-1.tmx', winScore: 0),
  (number: 2, pathname: 'level-2.tmx', winScore: 0),
  (number: 3, pathname: 'level-3.tmx', winScore: 0),
  (number: 4, pathname: 'level-4.tmx', winScore: 0),
  (number: 5, pathname: 'level-5.tmx', winScore: 0),
  (number: 6, pathname: 'level-6.tmx', winScore: 0),
];

typedef GameLevel = ({
  int number,
  String pathname,
  int winScore,
});
