import 'package:flutter/material.dart';

class PaddingView extends StatelessWidget {
  final double paddingLeft;
  final double paddingTop;
  final double paddingRight;
  final double paddingBottom;
  final Widget child;

  const PaddingView({
    super.key,
    this.paddingLeft = 10,
    this.paddingTop = 10,
    this.paddingRight = 10,
    this.paddingBottom = 10,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: paddingLeft,
        top: paddingTop,
        right: paddingRight,
        bottom: paddingBottom,
      ),
      child: child,
    );
  }
}
