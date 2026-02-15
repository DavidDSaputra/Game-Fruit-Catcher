import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

class Basket extends PositionComponent with HasGameReference, CollisionCallbacks {
  Basket() : super(size: Vector2(80, 60));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    position = Vector2(game.size.x / 2, game.size.y - 100);
    anchor = Anchor.center;
    add(RectangleHitbox());
  }

  void move(double newX) {
    position.x = newX.clamp(size.x / 2, game.size.x - size.x / 2);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.fill;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.x, size.y),
      const Radius.circular(10),
    );
    canvas.drawRRect(rect, paint);

    final handlePaint = Paint()
      ..color = Colors.brown[800]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final handlePath = Path()
      ..moveTo(10, 0)
      ..quadraticBezierTo(size.x / 2, -20, size.x - 10, 0);

    canvas.drawPath(handlePath, handlePaint);
  }
}
