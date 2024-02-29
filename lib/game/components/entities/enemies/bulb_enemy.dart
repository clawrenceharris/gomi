import 'dart:async';
import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:gomi/audio/sounds.dart';
import 'package:gomi/constants/animation_configs.dart';
import 'package:gomi/constants/globals.dart';
import 'package:gomi/game/components/entities/enemies/enemy.dart';
import 'package:gomi/game/components/entities/player.dart';

class BulbEnemy extends Enemy {
  late final int _direction;
  @override
  int get direction => _direction;
  BulbEnemy({required int direction, super.position, super.size}) {
    _direction = direction;
    sfx = SfxType.glassEnemy;
  }
  double _elapsedTime = 0.0;
  final Random rand = Random();

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(collisionType: CollisionType.passive));
    add(MoveEffect.to(Vector2(position.x, position.y - 14),
        EffectController(infinite: true, duration: 2, alternate: true)));

    return super.onLoad();
  }

  @override
  bool playerIsCorrectColor() {
    return world.player.color == GomiColor.black;
  }

  void _attack(double dt) {
    _elapsedTime += dt;
    if (_elapsedTime >= rand.nextInt(3) + 3) {
      world.add(Zap(
          position: Vector2(position.x, position.y + height / 2),
          direction: direction));
      _elapsedTime = 0.0;
    }

    if (scale.x > 1 && direction < 0) {
      flipHorizontallyAroundCenter();
    }
  }

  @override
  void swapDirection(Player other) {
    //dont swap direction
  }
  @override
  void playDeathSfx(SfxType sfx) {
    game.audioController.playSfx(sfx);
  }

  @override
  void update(double dt) {
    _attack(dt);

    super.update(dt);
  }

  @override
  void loadAllAnimations() {
    idleAnimation = AnimationConfigs.bulbEnemy.idle();
    attackAnimation = AnimationConfigs.bulbEnemy.attacking();
    current = GomiEntityState.attacking;
    super.loadAllAnimations();
  }
}

class Zap extends SpriteAnimationComponent with CollisionCallbacks {
  final int direction;
  final _speed = 60;
  late final Vector2 initialPosition = Vector2(position.x, position.y);
  double elapsedTime = 0.0;
  double activeTime = 9;
  Zap({super.position, required this.direction})
      : super(
            animation: AnimationConfigs.bulbEnemy.zap(),
            size: Vector2.all(Globals.tileSize));

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.x += direction * _speed * dt;
    if ((position.x - initialPosition.x).abs() >= 15 * Globals.tileSize) {
      removeFromParent();
    }
    super.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      other.hit();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
