import 'package:flutter/material.dart';

class VerifiedIcon extends StatelessWidget {
  final double size;
  final Color circleColor;
  final Color checkColor;
  const VerifiedIcon({
    super.key,
    required this.size,
    required this.circleColor,
    required this.checkColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(
          Icons.circle,
          color: checkColor,
          size: size,
        ),
        Icon(
          Icons.check_circle_rounded,
          color: circleColor,
          size: size,
        ),
      ],
    );
  }
}
