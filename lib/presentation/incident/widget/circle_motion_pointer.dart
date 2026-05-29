import 'dart:math';
import 'package:flutter/material.dart';

class CircularMotionPainter extends CustomPainter {
  final Animation<double> animation;
  CircularMotionPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final Paint paint = Paint()..style = PaintingStyle.fill;

    final int circleCount = 5;
    final double orbitRadius = size.width * 0.3; // مدى الدوران حول المركز

    // أحجام وشفافية مختلفة لكل دائرة
    final List<double> baseRadii = [15, 20, 25, 18, 22];
    final List<double> baseOpacity = [0.3, 0.5, 0.7, 0.4, 0.6];

    for (int i = 0; i < circleCount; i++) {
      // زاوية دوران كل دائرة (تختلف قليلاً لتكون موزعة)
      final double angle = (animation.value * 2 * pi) + (i * 2 * pi / circleCount);

      // احسب موقع كل دائرة حول المركز
      final double dx = center.dx + orbitRadius * cos(angle);
      final double dy = center.dy + orbitRadius * sin(angle);

      // حجم الدائرة
      final double radius = baseRadii[i];
      final double opacity = baseOpacity[i];

      paint.color = Colors.blue.withOpacity(opacity);

      // ارسم الدائرة
      canvas.drawCircle(Offset(dx, dy), radius, paint);
    }

    // دائرة المركز (مثلاً صورة أو عنصر)
    final Paint centerPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.red;

    canvas.drawCircle(center, 25, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
