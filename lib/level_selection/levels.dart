const gameLevels = <GameLevel>[
  (
    number: 1,
    pathname: 'level-1.tmx',
    winScore: 3,
  ),
  (
    number: 2,
    pathname: 'level-2.tmx',
    winScore: 5,
  ),
];

typedef GameLevel = ({
  int number,
  String pathname,
  int winScore,
});
