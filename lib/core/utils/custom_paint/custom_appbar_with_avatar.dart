import 'package:flutter/material.dart';

class ProfileAppBarDesign extends CustomPainter {
  final Color fillColor;

  ProfileAppBarDesign({
    required this.fillColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width / 2, 0, size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final ProfileAppBarDesign typedOther = other as ProfileAppBarDesign;
    return fillColor == typedOther.fillColor;
  }

  @override
  int get hashCode => fillColor.hashCode;
}
