import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gomi/audio/audio_controller.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/game/components/powerups/powerup.dart';
import 'package:gomi/game/widgets/powerup_widget.dart';
import 'package:gomi/player_stats/player_powerup.dart';
import 'package:gomi/player_stats/player_score.dart';
import 'package:gomi/utils.dart';
import 'package:provider/provider.dart';

class PowerupsMenuDialog extends StatefulWidget {
  const PowerupsMenuDialog({super.key});

  @override
  State<PowerupsMenuDialog> createState() => _PowerupsMenuDialog();
}

class _PowerupsMenuDialog extends State<PowerupsMenuDialog>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;
  List<Powerup> powerups = PlayerPowerups.allPowerups;
  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: powerups.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PlayerScore playerScore = context.watch<PlayerScore>();
    final AudioController audioController = context.watch<AudioController>();

    return AlertDialog(
      backgroundColor: Colors.transparent, // Make the background transparent
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Align(
              alignment: Alignment.topCenter,
              child: Stack(children: [
                Text("Powerups",
                    style: TextStyle(
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.lightBlue,
                        fontSize: 22,
                        fontFamily: 'Pixel',
                        fontWeight: FontWeight.bold)),
                const Text("Powerups",
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Pixel',
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ]),
            ),
          ),
          Stack(
            children: [
              Container(
                  width: 600,
                  height: 360,
                  decoration: const BoxDecoration(
                    color: Colors
                        .transparent, // Set the background color to transparent

                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/hud/menu_panel.png'), // Replace with your image path
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Stack(
                    children: [
                      PageView(

                          /// [PageView.scrollDirection] defaults to [Axis.horizontal].
                          /// Use [Axis.vertical] to scroll vertically.
                          controller: _pageViewController,
                          onPageChanged: _handlePageViewChanged,
                          children: List.generate(
                              powerups.length,
                              (index) =>
                                  PowerupWidget(powerup: powerups[index]))),
                      ValueListenableBuilder<int>(
                          valueListenable: playerScore.totalCoins,
                          builder: (context, coins, child) {
                            return Positioned(
                              top: 25,
                              right: 25,
                              child: Row(
                                children: [
                                  Image.asset(
                                      width: 30,
                                      height: 30,
                                      "assets/images/collectibles/coin.png"),
                                  const SizedBox(width: 5),
                                  Text(
                                    coins.toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Pixel'),
                                  ),
                                ],
                              ),
                            );
                          }),
                      Positioned(
                          top: 20,
                          left: 10,
                          child: TextButton(
                              onPressed: () {
                                audioController.playSfx(SfxType.buttonTap);
                                _handleCloseButtonPress(context);
                              },
                              child: Image.asset(
                                  width: 30,
                                  height: 30,
                                  "assets/images/icons/close.png"))),
                    ],
                  )),
            ],
          ),
          PageIndicator(
            tabController: _tabController,
            currentPageIndex: _currentPageIndex,
            onUpdateCurrentPageIndex: _updateCurrentPageIndex,
            isOnDesktopAndWeb: !isMobile(),
          ),
        ],
      ),
    );
  }

  void _handleCloseButtonPress(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _handlePageViewChanged(int currentPageIndex) {
    if (!_isOnDesktopAndWeb) {
      return;
    }
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  bool get _isOnDesktopAndWeb {
    if (kIsWeb) {
      return true;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return true;
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return false;
    }
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
    required this.isOnDesktopAndWeb,
  });

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;
  final bool isOnDesktopAndWeb;

  @override
  Widget build(BuildContext context) {
    if (!isOnDesktopAndWeb) {
      return const SizedBox.shrink();
    }
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            splashRadius: 16.0,
            padding: EdgeInsets.zero,
            onPressed: () {
              if (currentPageIndex == 0) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex - 1);
            },
            icon: const Icon(
              Icons.arrow_left_rounded,
              size: 32.0,
              color: Colors.white,
            ),
          ),
          TabPageSelector(
            controller: tabController,
            color: colorScheme.background,
            selectedColor: Colors.lightBlue,
          ),
          IconButton(
            splashRadius: 16.0,
            padding: EdgeInsets.zero,
            onPressed: () {
              if (currentPageIndex == tabController.length - 1) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex + 1);
            },
            icon: const Icon(
              Icons.arrow_right_rounded,
              size: 32.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
