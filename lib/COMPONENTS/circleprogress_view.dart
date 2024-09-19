import 'package:flutter/material.dart';
import 'dart:math';

class CircleProgressView extends StatefulWidget {
  final double percentage;
  final Color color;
  final int thickness;
  final double size;

  const CircleProgressView(
      {super.key,
      required this.percentage,
      this.color = Colors.black,
      this.thickness = 10,
      this.size = 60 // Default value for thickness
      });

  @override
  State<CircleProgressView> createState() => _CircleProgressViewState();
}

class _CircleProgressViewState extends State<CircleProgressView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: widget.size,
            height: widget.size,
            child: CustomPaint(
              painter: _CircularProgressPainter(
                widget.percentage,
                widget.color,
                widget.thickness.toDouble(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double percentage;
  final Color color;
  final double thickness;

  _CircularProgressPainter(this.percentage, this.color, this.thickness);

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = Colors.grey[200]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    Paint progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round; // Rounded edges

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = (size.width - thickness) / 2;

    // Draw the background circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw the progress arc with rounded edges
    double sweepAngle = 2 * pi * (percentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start angle (top of the circle)
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Redraw when percentage changes
  }
}
