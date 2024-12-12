import 'package:flutter/material.dart';
import 'package:nova_wheels/features/vehicle/presentation/shared/enums/vehicle_status_enum.dart';

class VehicleStatusChipPainter extends CustomPainter {
  final String status;

  VehicleStatusChipPainter({required this.status});

  @override
  void paint(Canvas canvas, Size size) {
    final VehicleStatus statusEnum = VehicleStatus.values.firstWhere(
      (e) => e.displayName == status,
      orElse: () => VehicleStatus.available,
    );

    final paint = Paint()
      ..color = switch (statusEnum) {
        VehicleStatus.available => Colors.green,
        VehicleStatus.booked => Colors.blue,
        VehicleStatus.rented => Colors.orange,
        VehicleStatus.sold => Colors.red,
      }
      ..style = PaintingStyle.fill;

    final backgroundRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(2),
    );

    canvas.drawRRect(backgroundRect, paint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: status.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          // height: 1,
          letterSpacing: 1,

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

class VehicleStatusChip extends StatelessWidget {
  final String status;

  const VehicleStatusChip({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(90, 25),
      painter: VehicleStatusChipPainter(
        status: status,
      ),
    );
  }
}
