import 'package:flutter/material.dart';

class AvailabilityPainter extends CustomPainter {
  final String label;
  final bool isAvailable;

  AvailabilityPainter({required this.label, required this.isAvailable});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isAvailable ? Colors.green : Colors.red
      ..style = PaintingStyle.fill;

    final backgroundRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(12),
    );

    // Draw the background rectangle with rounded corners
    canvas.drawRRect(backgroundRect, paint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: 0, maxWidth: size.width);

    textPainter.paint(
      canvas,
      Offset((size.width - textPainter.width) / 2,
          (size.height - textPainter.height) / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AvailabilityChip extends StatelessWidget {
  final String label;
  final bool isAvailable;

  const AvailabilityChip({
    super.key,
    required this.label,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 20),
      painter: AvailabilityPainter(label: label, isAvailable: isAvailable),
    );
  }
}
