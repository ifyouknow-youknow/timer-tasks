import 'package:flutter/material.dart';

class BorderView extends StatelessWidget {
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;

  final double topWidth;
  final Color topColor;
  final double bottomWidth;
  final Color bottomColor;
  final double leftWidth;
  final Color leftColor;
  final double rightWidth;
  final Color rightColor;

  final Widget child;

  const BorderView({
    Key? key,
    this.top = false,
    this.bottom = false,
    this.left = false,
    this.right = false,
    this.topWidth = 1.0,
    this.topColor = Colors.black,
    this.bottomWidth = 1.0,
    this.bottomColor = Colors.black,
    this.leftWidth = 1.0,
    this.leftColor = Colors.black,
    this.rightWidth = 1.0,
    this.rightColor = Colors.black,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: top
              ? BorderSide(width: topWidth, color: topColor)
              : BorderSide.none,
          bottom: bottom
              ? BorderSide(width: bottomWidth, color: bottomColor)
              : BorderSide.none,
          left: left
              ? BorderSide(width: leftWidth, color: leftColor)
              : BorderSide.none,
          right: right
              ? BorderSide(width: rightWidth, color: rightColor)
              : BorderSide.none,
        ),
      ),
      child: child,
    );
  }
}
