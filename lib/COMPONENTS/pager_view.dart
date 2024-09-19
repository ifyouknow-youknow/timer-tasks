import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PagerView extends StatefulWidget {
  final List<Widget> children;
  final Color dotColor;
  final Color activeDotColor;
  final double dotSize;

  const PagerView({
    super.key,
    required this.children,
    this.dotColor = Colors.grey,
    this.activeDotColor = Colors.blue,
    this.dotSize = 8,
  });

  @override
  _PagerViewState createState() => _PagerViewState();
}

class _PagerViewState extends State<PagerView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            children: widget.children.map((child) {
              return Container(
                child: child,
                // Add styling as needed for each page
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SmoothPageIndicator(
            controller: _pageController,
            count: widget.children.length,
            effect: WormEffect(
              dotWidth: widget.dotSize,
              dotHeight: widget.dotSize,
              spacing: 8.0,
              dotColor: widget.dotColor,
              activeDotColor: widget.activeDotColor,
            ),
          ),
        ),
      ],
    );
  }
}
