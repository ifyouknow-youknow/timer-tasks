import 'package:flutter/material.dart';
import 'package:timer_tasks/COMPONENTS/blur_view.dart';
import 'package:timer_tasks/COMPONENTS/padding_view.dart';
import 'package:timer_tasks/COMPONENTS/roundedcorners_view.dart';
import 'package:timer_tasks/MODELS/screen.dart';

class PopupView extends StatefulWidget {
  final Widget child;
  const PopupView({super.key, required this.child});

  @override
  State<PopupView> createState() => _PopupViewState();
}

class _PopupViewState extends State<PopupView> {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BlurView(
        child: Center(
          child: SizedBox(
            width: getWidth(context) * 0.8,
            child: IntrinsicHeight(
              child: RoundedCornersView(
                backgroundColor: Colors.white,
                child: PaddingView(
                    paddingTop: 15,
                    paddingBottom: 15,
                    paddingLeft: 15,
                    paddingRight: 15,
                    child: widget.child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
