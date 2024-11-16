import 'package:flutter/material.dart';

class SlimVerificationPainter extends CustomPainter {
  final bool isVerified;

  SlimVerificationPainter(this.isVerified);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isVerified ? Colors.green : Colors.red
      ..style = PaintingStyle.fill;

    final backgroundRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(6),
    );

    // Draw the background rectangle with rounded corners
    canvas.drawRRect(backgroundRect, paint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: isVerified ? 'Verified' : 'Not Verified',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: 0, maxWidth: size.width);

    // Draw the text centered within the label
    textPainter.paint(
      canvas,
      Offset((size.width - textPainter.width) / 2,
          (size.height - textPainter.height) / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SlimVerificationLabel extends StatelessWidget {
  final bool isVerified;

  const SlimVerificationLabel({super.key, required this.isVerified});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(60, 18),
      painter: SlimVerificationPainter(isVerified),
    );
  }
}
