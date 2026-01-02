import 'dart:math' as math;
import 'package:flutter/material.dart';

class ShakePulse extends StatefulWidget {
  final Widget child;
  final double shakeOffset;
  final double minScale;
  final double maxScale;
  final Duration duration;

  const ShakePulse({
    super.key,
    required this.child,
    this.shakeOffset = 6,
    this.minScale = 1.0,
    this.maxScale = 1.06,
    this.duration = const Duration(seconds: 1),
  });

  @override
  State<ShakePulse> createState() => _ShakePulseState();
}

class _ShakePulseState extends State<ShakePulse> {
  bool reverse = false;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: ValueKey(reverse),               // 🔥 IMPORTANT – forces rebuild
      tween: Tween(begin: 0, end: 1),
      duration: widget.duration,
      curve: Curves.easeInOut,
      onEnd: () => setState(() => reverse = !reverse),   // 🔄 Loop
      builder: (context, value, child) {
        // Shake movement
        final shake =
            math.sin(value * 3.14 * 4) * widget.shakeOffset;

        // Pulse scale
        final scale = widget.minScale +
            (widget.maxScale - widget.minScale) *
                (0.5 + 0.5 * math.sin(value * 3.14 * 2));

        return Transform.translate(
          offset: Offset(shake, 0),
          child: Transform.scale(
            scale: scale,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
