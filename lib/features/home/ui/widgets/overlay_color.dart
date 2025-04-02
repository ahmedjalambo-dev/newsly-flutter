import 'package:flutter/material.dart';

class OverlayColor extends StatelessWidget {
  final double topLeftRadius;
  final double topRightRadius;
  final double bottomRightRadius;
  final double bottomLeftRadius;
  final List<Color> gradientColors;

  const OverlayColor({
    super.key,
    this.topLeftRadius = 0.0,
    this.topRightRadius = 0.0,
    this.bottomRightRadius = 0.0,
    this.bottomLeftRadius = 0.0,
    this.gradientColors = const [
      Colors.black54,
      Colors.black45,
      Colors.black38,
      Colors.black26,
      Colors.black38,
      Colors.black45,
      Colors.black54,
      Colors.black87,
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeftRadius),
            topRight: Radius.circular(topRightRadius),
            bottomRight: Radius.circular(bottomRightRadius),
            bottomLeft: Radius.circular(bottomLeftRadius),
          ),
          gradient: LinearGradient(
            end: AlignmentDirectional.bottomCenter,
            begin: AlignmentDirectional.topCenter,
            colors: gradientColors,
          ),
        ),
      ),
    );
  }
}
