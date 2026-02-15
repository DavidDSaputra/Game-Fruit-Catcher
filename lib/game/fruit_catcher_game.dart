import 'dart:async';
import 'dart:math';

import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import 'components/basket.dart';
import 'components/fruit.dart';
import 'managers/audio_manager.dart';

class FruitCatcherGame extends FlameGame with PanDetector, HasCollisionDetection {
  final ValueNotifier<int> scoreNotifier = ValueNotifier(0);
  final Random random = Random();

  late Basket basket;
  double spawnTimer = 0;

  @override
  Color backgroundColor() => const Color(0xFF87CEEB);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    basket = Basket();
    add(basket);

    AudioManager().playBackgroundMusic();
  }

  @override
  void update(double dt) {
    super.update(dt);

    spawnTimer += dt;
    if (spawnTimer > 1.2) {
      spawnFruit();
      spawnTimer = 0;
    }
  }

  void spawnFruit() {
    final x = random.nextDouble() * size.x;

    add(
      Fruit(
        position: Vector2(x, -40),
      ),
    );
  }

  void incrementScore() {
    scoreNotifier.value++;
    AudioManager().playSfx('collect.mp3');
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    basket.move(info.eventPosition.global.x);
  }

  @override
  void onPanStart(DragStartInfo info) {
    basket.move(info.eventPosition.global.x);
  }
}
