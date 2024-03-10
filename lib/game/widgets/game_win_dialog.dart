import 'dart:js';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gomi/level_selection/levels.dart';
import './button.dart';
import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:uuid/uuid.dart';

/// This dialog is shown when a level is completed.
/// it lets the user go to the next level, or otherwise back to the level
/// selection screen.
class GameWinDialog extends StatelessWidget {
  const GameWinDialog({
    super.key,
    required this.level,
    required this.stars,
  });

  /// The properties of the level that was just finished.
  final GameLevel level;

  /// How many seconds that the level was completed in.
  final int stars;

  //Container height and width
  final double cwidth = 600;
  final double cheight = 360;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: cwidth,
        height: cheight,
        decoration: const BoxDecoration(
          color: Colors.transparent, // Set the background color to transparent

          image: DecorationImage(
            image: AssetImage(
                'assets/images/hud/menu_panel.png'), // Replace with your image path
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Well Done!',
              style: TextStyle(
                  fontSize: 22, fontFamily: 'Pixel', color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'You completed the level and earned $stars stars!',
              textAlign: TextAlign.center,
              style: const TextStyle(fontFamily: 'Pixel', color: Colors.white),
            ),
            const SizedBox(height: 16),
            if (level.number < gameLevels.length) ...[
              Button(
                onPressed: () {
                  context.go('/play/session/${level.number + 1}');
                },
                text: 'Next level',
              ),
              const SizedBox(height: 16),
            ],
            if (level.number >= gameLevels.length && Platform.isAndroid) ...[
              AddToGoogleWalletButton(
                pass: _gomiHeroBadge,
                onSuccess: () => _showSnackBar(context, "Success!"),
                onCanceled: () => _showSnackBar(context, "Action canceled"),
                onError: (Object error) =>
                    _showSnackBar(context, error.toString()),
              ),
            ],
            Button(
              onPressed: () {
                context.go('/play');
              },
              text: 'Go Back',
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String text) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

final String _passId = const Uuid().v4();
const String _passClass = 'GomiHeroBadge';
const String _issuerId = '3388000000022328615';
const String _issuerEmail = 'angelsantiago094@gmail.com';

final String _gomiHeroBadge = """
    {
      "iss": "$_issuerEmail",
      "aud": "google",
      "typ": "savetowallet",
      "origins": [],
      "payload": {
        "genericObjects": [
          {
            "id": "$_issuerId.$_passId",
            "classId": "$_issuerId.$_passClass",
            "genericType": "GENERIC_TYPE_UNSPECIFIED",
            "hexBackgroundColor": "#3a453a",
            "logo": {
              "sourceUri": {
                "uri": "https://i.imgur.com/nwWyDgt.png"
              }
            },
            "cardTitle": {
              "defaultValue": {
                "language": "en",
                "value": "Gomi Badge"
              }
            },
            "subheader": {
              "defaultValue": {
                "language": "en",
                "value": 'Congratulations!  That was no easy task, and Gomi can finally relax.  What happened to the litter critters, you ask?  Well, some say they hear whispers coming from recycled products, and garden fertilizer...    "Reduce... reuse... recycle... "'
              }
            },
            "header": {
              "defaultValue": {
                "language": "en",
                "value": "The End of a (re)Cycle"
              }
            },
            "heroImage": {
              "sourceUri": {
                "uri": "https://i.imgur.com/K96ujwo.png"
              }
            },
            "textModulesData": [
              {
                "header": "Gomi Award",
                "body": "Completed Gomi Hero",
                "id": "complete"
              }
            ]
          }
        ]
      }
    }
""";
