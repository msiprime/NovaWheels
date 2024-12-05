import 'dart:ui' show Path, PathMetric, RRect, Rect;

import 'package:flutter/material.dart';

class DottedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;
  final double borderRadius;

  DottedBorderPainter({
    required this.color,
    this.strokeWidth = 2.0,
    this.dashWidth = 4.0,
    this.dashGap = 4.0,
    this.borderRadius = 12.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(borderRadius),
        ),
      );

    final dashPath = Path();

    for (PathMetric pathMetric in path.computeMetrics()) {
      for (double i = 0; i < pathMetric.length; i += dashWidth + dashGap) {
        final extractPath = pathMetric.extractPath(i, i + dashWidth);
        dashPath.addPath(extractPath, Offset.zero);
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
