import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/components/animated_score_text.dart';
import 'package:gomi/game/components/entities/gomi_entity.dart';
import 'package:gomi/game/gomi_game.dart';
import 'package:gomi/player_stats/player_health.dart';
import 'package:gomi/player_stats/player_score.dart';

enum GomiEntityState {
  idle,
  walking,
  jumping,
  falling,
  hit,
  disappearing,
  appearing,
  attacking,
  ground,
  rising,
  apex,
}

enum GomiColor {
  black("black"),
  green("green"),
  red("red"),
  blue("blue");

  const GomiColor(this.color);
  final String color;
}

class Player extends GomiEntity
    with HasGameRef<Gomi>, KeyboardHandler, CollisionCallbacks {
  Player(
      {required this.color,
      required this.playerHealth,
      required this.playerScore,
      super.position})
      : super(anchor: Anchor.topCenter) {
    initialPosition = Vector2(position.x, position.y);
  }

  GomiColor color;
  int _jumpCount = 0;
  final double _speed = 120;
  @override
  double get speed => _speed;
  bool hasJumped = false;
  late final ValueNotifier<bool> seedCollected;
  final PlayerHealth playerHealth;
  final PlayerScore playerScore;
  late final Vector2 _minClamp;
  late final Vector2 _maxClamp;

  @override
  FutureOr<void> onLoad() {
    _loadAnimations();
    playerScore.score.addListener(_onScoreIncrease);
    add(RectangleHitbox());
    seedCollected = ValueNotifier(false);
    // Prevents player from going out of bounds of level.
    // Since anchor is top center, split size in half for calculation.
    _minClamp = game.world.levelBounds.topLeft;
    _maxClamp = game.world.levelBounds.bottomRight + (size / 2);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updateState();
    applyPhysics(dt);
    if (!seedCollected.value) {
      _updateMovement(dt);
    } else {
      velocity.x = 0;
    }

    super.update(dt);
  }

  void respawn() {
    position = Vector2(initialPosition.x, initialPosition.y);
    direction = 0;
    velocity = Vector2.zero();
    current = GomiEntityState.idle;
    changeColor(GomiColor.black);
    _loadAnimations();
  }

  void _loadAnimations() {
    SpriteAnimation idleAnimation = AnimationConfigs.gomi.idle(color.color);
    SpriteAnimation walkingAnimation =
        AnimationConfigs.gomi.walking(color.color);
    SpriteAnimation jumpingAnimation =
        AnimationConfigs.gomi.jumping(color.color);
    SpriteAnimation disappearingAnimation =
        AnimationConfigs.gomi.disappearing();
    SpriteAnimation appearingAnimation = AnimationConfigs.gomi.appearing();
    SpriteAnimation hitAnimation = AnimationConfigs.gomi.hit(color.color);

    // List of all animations
    animations = {
      GomiEntityState.idle: idleAnimation,
      GomiEntityState.walking: walkingAnimation,
      GomiEntityState.jumping: jumpingAnimation,
      GomiEntityState.disappearing: disappearingAnimation,
      GomiEntityState.appearing: appearingAnimation,
      GomiEntityState.hit: hitAnimation,
    };

    current = GomiEntityState.idle;
  }

  void _onScoreIncrease() {
    AnimatedScoreText text = AnimatedScoreText(
        text: playerScore.pointsAdded.toString(), position: position);

    game.world.add(text);
  }

  void changeColor(GomiColor color) {
    this.color = color;
    _loadAnimations();
  }

  void bounce() {
    game.audioController.playSfx(SfxType.jump);

    velocity.y = -bounceForce;
  }

  void _updateState() {
    GomiEntityState playerState = GomiEntityState.idle;
    if (velocity.x != 0) {
      playerState = GomiEntityState.walking;
    }
    if (velocity.y < 0 && !isGrounded) {
      playerState = GomiEntityState.jumping;
    }

    if (gotHit) {
      playerState = GomiEntityState.hit;
    }

    if (scale.x < 0 && velocity.x > 0 || scale.x > 0 && velocity.x < 0) {
      flipHorizontallyAroundCenter();
    }

    current = playerState;
  }

  Future<void> hit() async {
    if (gotHit) {
      //dont hit if we are currently being hit
      return;
    }
    gotHit = true;
    playerHealth.decrease();

    await Future.delayed(const Duration(seconds: 1));

    current = GomiEntityState.idle;
    gotHit = false;
  }

  void _updateMovement(double dt) {
    if (hasJumped) _jump(dt);

    velocity.x = direction * _speed;
    position.x += velocity.x * dt;
    position.clamp(_minClamp, _maxClamp);
  }

  void _jump(double dt) {
    hasJumped = false;

    if (isGrounded) {
      // Player is grounded, perform a regular jump
      velocity.y = -jumpForce;
      position.y += velocity.y * dt;
      _jumpCount = 1;
      game.audioController.playSfx(SfxType.jump);

      isGrounded = false;
    } else if (_jumpCount < 2) {
      // Perform a double jump
      game.audioController.playSfx(SfxType.doubleJump);

      velocity.y = -jumpForce;
      position.y += velocity.y * dt;

      // Set jump count to 2 to indicate a double jump has been used
      _jumpCount = 2;
    }
  }
}
