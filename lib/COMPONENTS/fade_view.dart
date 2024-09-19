import 'package:flutter/material.dart';

class FadeView extends StatefulWidget {
  final Widget child;
  final int seconds;

  const FadeView({
    super.key,
    required this.child,
    this.seconds = 2, // default to 2 seconds if not provided
  });

  @override
  _FadeViewState createState() => _FadeViewState();
}

class _FadeViewState extends State<FadeView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: widget.seconds),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: widget.child,
        );
      },
    );
  }
}
