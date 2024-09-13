import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedWrapper extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;

  const AnimatedWrapper({
    super.key,
    required this.child,
    this.delay = const Duration(milliseconds: 300),
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: child
          .animate()
          .fadeIn(duration: duration)
          .scale(duration: duration)
          .move(delay: delay, duration: duration),
    );
  }
}
