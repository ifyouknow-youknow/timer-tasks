import 'package:flutter/material.dart';

class ProgressView extends StatefulWidget {
  final double percentage;
  final Color color;
  final double height;

  const ProgressView({
    super.key,
    required this.percentage,
    this.color = Colors.blueGrey,
    this.height = 10,
  });

  @override
  State<ProgressView> createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Full width of the parent container
      height: widget.height, // Height of the progress bar
      decoration: BoxDecoration(
        color: Colors.grey[200], // Background color for the unfilled part
        borderRadius:
            BorderRadius.circular(widget.height / 2), // Rounded corners
      ),
      child: Stack(
        children: [
          // Filled portion of the progress bar
          FractionallySizedBox(
            widthFactor: widget.percentage / 100, // Percentage width
            child: Container(
              decoration: BoxDecoration(
                color: widget.color, // Color of the filled portion
                borderRadius:
                    BorderRadius.circular(widget.height / 2), // Rounded corners
              ),
            ),
          ),
        ],
      ),
    );
  }
}
