import 'package:flutter/material.dart';
import 'dart:ui';

class BlurView extends StatelessWidget {
  final double intensity;
  final Color color;
  final Widget child;

  const BlurView({
    super.key,
    this.intensity = 10.0,
    this.color = const Color(0x80000000), // 50% opacity black
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: intensity,
          sigmaY: intensity,
        ),
        child: Container(
          color: color,
          child: child,
        ),
      ),
    );
  }
}
