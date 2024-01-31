const gameLevels = <GameLevel>[
  (
    number: 1,
    pathname: 'level-1.tmx',
    winScore: 0,
  ),
  (
    number: 2,
    pathname: 'level-2.tmx',
    winScore: 0,
  ),
];

typedef GameLevel = ({
  int number,
  String pathname,
  int winScore,
});
