import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/game/components/collision%20blocks/one_way_platform.dart';
import 'package:gomi/game/components/custom_hitbox.dart';
import 'package:gomi/game/gomi_game.dart';

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

  const GomiColor(this.color);
  final String color;
}

class PlayerLives extends ChangeNotifier {
  int _count = Globals.maxLives;

  int get count => _count;
  ValueNotifier<int> getValueNotifier() {
    return ValueNotifier<int>(_count);
  }

  /// Resets the player's progress so it's like if they just started
  /// playing the game for the first time.
  void reset() {
    _count = Globals.maxLives;
    notifyListeners();
  }

  void decrease() {
    _count -= 1;
    notifyListeners();
  }
}

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<Gomi>, KeyboardHandler, CollisionCallbacks {
  Player({required this.color, super.position})
      : super(anchor: Anchor.topCenter);

  GomiColor color;
  int _jumpCount = 0;
  final int maxLives = 3;
  final double _gravity = 9.8;
  final double _jumpForce = 200;
  final double _maxVelocity = 300;
  final double _bounceForce = 200;
  bool hasJumped = false;
  bool seedCollected = false;
  double directionX = 0;
  double moveSpeed = 100;
  late final Vector2 startingPosition;
  Vector2 velocity = Vector2.zero();
  bool isGrounded = false;
  final PlayerLives lives = PlayerLives();
  double jumpCooldown = 1.5;
  double lastJumpTimestamp = 0.0;
  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;
  bool gotHit = false;
  late final Vector2 _minClamp;
  late final Vector2 _maxClamp;
  late final CustomHitbox hitbox;
  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    // debugMode = true;

    // Prevents player from going out of bounds of level.
    // Since anchor is top center, split size in half for calculation.
    _minClamp = game.world.levelBounds.topLeft;
    _maxClamp = game.world.levelBounds.bottomRight + (size / 2);
    hitbox = CustomHitbox(width: width - 8, height: height, offsetX: 4);
    startingPosition = Vector2(position.x, position.y);
    add(RectangleHitbox(
      position: Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height),
    ));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    accumulatedTime += dt;

    while (accumulatedTime >= fixedDeltaTime) {
      _updatePlayerState();
      _checkHorizontalCollisions();
      _applyGravity(fixedDeltaTime);
      _checkVerticalCollisions();

      if (!seedCollected) {
        _updatePlayerMovement(fixedDeltaTime);
      } else {
        velocity.x = 0;
      }

      accumulatedTime -= fixedDeltaTime;
    }

    super.update(dt);
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

  void changeColor(GomiColor color) {
    this.color = color;
    _loadAllAnimations();
  }

  void bounce() {
    game.audioController.playSfx(SfxType.jump);

    velocity.y = -_bounceForce;
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

    if (scale.x < 0 && velocity.x > 0 || scale.x > 0 && velocity.x < 0) {
      flipHorizontallyAroundCenter();
    }

    current = playerState;
  }

  void respawn() async {
    lives.reset();
    scale.x = 1;
    velocity = Vector2.zero();
    position = Vector2(startingPosition.x, startingPosition.y);
    current = PlayerState.idle;
    changeColor(GomiColor.black);
  }

  Future<void> hit() async {
    gotHit = true;
    await Future.delayed(const Duration(seconds: 1));
    lives.decrease();
    if (lives.count == 0) game.world.playerDeathNotifier.handlePlayerDeath();

    current = PlayerState.idle;
    gotHit = false;
  }

  void _updatePlayerMovement(double dt) {
    if (hasJumped) _jump(dt);

    velocity.x = directionX * moveSpeed;
    position.x += velocity.x * dt;
    position.clamp(_minClamp, _maxClamp);
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

  void _applyGravity(double dt) {
    velocity.y += _gravity;
    velocity.y = velocity.y.clamp(-_jumpForce, _maxVelocity);
    position.y += velocity.y * dt;
  }

  void _checkHorizontalCollisions() {
    for (final block in game.world.collisionBlocks) {
      if (block.blockRect.overlaps(game.camera.visibleWorldRect)) {
        if (block is OneWayPlatform == false) {
          if (game.world.checkCollisionTopCenter(this, block)) {
            if (velocity.x > 0) {
              velocity.x = 0;
              position.x = block.x - width / 2;
              break;
            }
            if (velocity.x < 0) {
              velocity.x = 0;
              position.x = block.x + block.width + width / 2;
              break;
            }
          }
        }
      }
    }
  }

  void _checkVerticalCollisions() {
    var topCollisionPaddingY = 0.2;

    for (final block in game.world.collisionBlocks) {
      if (block.blockRect.overlaps(game.camera.visibleWorldRect)) {
        if (block is OneWayPlatform) {
          if (game.world.isCollisionFromTopPlayer(this, block)) {
            if (velocity.y > 0) {
              velocity.y = 0;
              position.y = block.y - hitbox.height - topCollisionPaddingY;
              isGrounded = true;
              break;
            }
          }
        } else {
          if (game.world.checkCollisionTopCenter(this, block)) {
            if (velocity.y > 0) {
              velocity.y = 0;
              position.y = block.y - hitbox.height;
              isGrounded = true;
              break;
            }
            if (velocity.y < 0) {
              velocity.y = 0;
              position.y = block.y + block.height;
            }
          }
        }
      }
    }
  }
}
