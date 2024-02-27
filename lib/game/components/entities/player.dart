import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/game/gomi_game.dart';
import 'dart:async';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/game/components/animated_score_text.dart';
import 'package:gomi/game/gomi_level.dart';
import 'package:gomi/player_stats/player_health.dart';
import 'package:gomi/player_stats/player_score.dart';

enum PlayerState {
  idle,
  walking,
  jumping,
  falling,
  hit,
  disappearing,
  appearing
}

enum GomiColor {
  black("black"),
  green("green"),
  red("red"),
  blue("blue");

  final String color;
  const GomiColor(this.color);
}

class Player extends SpriteAnimationGroupComponent<PlayerState>
    with
        CollisionCallbacks,
        KeyboardHandler,
        HasGameRef<Gomi>,
        HasWorldReference<GomiLevel> {
  final double _gravity = 7;
  final Vector2 velocity = Vector2.zero();

  int _jumpCount = 0;
  final double _jumpForce = 200;
  final double _maxVelocity = 150;
  final double _bounceForce = 200;
  bool hasJumped = false;
  bool seedCollected = false;
  double directionX = 0;
  double moveSpeed = 100;
  final PlayerHealth playerHealth;
  final PlayerScore playerScore;

  bool isGrounded = false;
  double jumpCooldown = 1.5;
  double lastJumpTimestamp = 0.0;
  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;
  bool gotHit = false;

  GomiColor color = GomiColor.black;

  Player({
    super.position,
    required this.color,
    required this.playerHealth,
    required this.playerScore,
  }) : super(anchor: Anchor.topLeft) {
    debugMode = true;

    add(RectangleHitbox());
  }

  void _loadAllAnimations() {
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
      PlayerState.idle: idleAnimation,
      PlayerState.walking: walkingAnimation,
      PlayerState.jumping: jumpingAnimation,
      PlayerState.disappearing: disappearingAnimation,
      PlayerState.appearing: appearingAnimation,
      PlayerState.hit: hitAnimation
    };

    // Set current animation
    current = PlayerState.idle;
  }

  @override
  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    _loadAllAnimations();

    playerScore.score.addListener(onScoreIncrease);

    return super.onLoad();
  }

  void onScoreIncrease() {
    AnimatedScoreText text = AnimatedScoreText(
        text: playerScore.pointsAdded.toString(), position: position);

    world.add(text);
  }

  bool fromLeft(PositionComponent other) {
    return velocity.x > 0 &&
        (position.x + width - other.position.x).toInt() <= 1;
  }

  bool fromRight(PositionComponent other) {
    return velocity.x < 0 &&
        (other.position.x + other.width - position.x).toInt() <= 3;
  }

  bool fromAbove(PositionComponent other) {
    return velocity.y > 0 &&
        (other.position.y - (position.y + height)).toInt() <= 1 &&
        (other.position.y - (position.y + height)).toInt() >= -height / 2 &&
        x + width > other.x &&
        x < other.x + other.width;
  }

  bool fromBelow(PositionComponent other) {
    return (other.position.y + other.height - (position.y)).toInt() <= 2 &&
        x + width > other.x &&
        x < other.x + other.width;
  }

  void changeColor(GomiColor color) {
    this.color = color;
    _loadAllAnimations();
  }

  void bounce() {
    game.audioController.playSfx(SfxType.jump);

    velocity.y = -_bounceForce;
  }

  Future<void> hit() async {
    if (gotHit) {
      //dont hit if we are currently being hit
      return;
    }
    gotHit = true;
    playerHealth.decrease();

    await Future.delayed(const Duration(seconds: 1));

    current = PlayerState.idle;
    gotHit = false;
  }

  void updateVelocity() {
    velocity.x = moveSpeed * directionX;
    velocity.y += _gravity;
    velocity.y = velocity.y.clamp(-_jumpForce, _maxVelocity);
  }

  void updatePosition(double dt) {
    Vector2 distance = velocity * dt;
    position += distance;
  }

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;
    if (velocity.x != 0) {
      playerState = PlayerState.walking;
    }
    if (velocity.y < 0 && !isGrounded) {
      playerState = PlayerState.jumping;
    }

    if (gotHit) {
      playerState = PlayerState.hit;
    }

    current = playerState;
  }

  void _updateJump(double dt) {
    if (hasJumped) _jump(dt);
  }

  void _jump(double dt) {
    hasJumped = false;

    if (isGrounded) {
      // Player is grounded, perform a regular jump
      velocity.y = -_jumpForce;
      position.y += velocity.y * dt;
      _jumpCount = 1;
      game.audioController.playSfx(SfxType.jump);

      isGrounded = false;
    } else if (_jumpCount < 2) {
      // Perform a double jump
      game.audioController.playSfx(SfxType.doubleJump);

      velocity.y = -_jumpForce;
      position.y += velocity.y * dt;

      // Set jump count to 2 to indicate a double jump has been used
      _jumpCount = 2;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    updateVelocity();
    updatePosition(dt);
    _updatePlayerState();
    _updateJump(dt);
  }
}
