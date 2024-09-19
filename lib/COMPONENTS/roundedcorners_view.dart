import 'package:flutter/material.dart';

class RoundedCornersView extends StatelessWidget {
  final double topLeft;
  final double topRight;
  final double bottomLeft;
  final double bottomRight;
  final Color backgroundColor;
  final Widget child;

  const RoundedCornersView({
    super.key,
    this.topLeft = 10,
    this.topRight = 10,
    this.bottomLeft = 10,
    this.bottomRight = 10,
    this.backgroundColor = Colors.transparent,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topLeft),
        topRight: Radius.circular(topRight),
        bottomLeft: Radius.circular(bottomLeft),
        bottomRight: Radius.circular(bottomRight),
      ),
      child: Container(
        color: backgroundColor,
        child: Column(
          children: [child],
        ),
      ),
    );
  }
}
