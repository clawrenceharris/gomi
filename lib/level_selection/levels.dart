const gameLevels = <GameLevel>[
  (number: 1, pathname: 'level_1.tmx', winScore: 0),
  (number: 2, pathname: 'level_2.tmx', winScore: 0),
  (number: 3, pathname: 'level_3.tmx', winScore: 0),
  (number: 4, pathname: 'level_4.tmx', winScore: 0),
  (number: 5, pathname: 'level_5.tmx', winScore: 0),
  (number: 6, pathname: 'level_6.tmx', winScore: 0),
  (number: 7, pathname: 'level_7.tmx', winScore: 0),
];

typedef GameLevel = ({
  int number,
  String pathname,
  int winScore,
});
