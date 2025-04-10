import 'dart:ui';

import 'package:flutter/material.dart';

class BlurCircleIconButton extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;
  final double blurRadius;
  final Color circleColor;
  final Color iconColor;

  const BlurCircleIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.blurRadius = 0.0,
    this.iconColor = Colors.black,
    this.circleColor = const Color.fromRGBO(238, 238, 238, 1),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: circleColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurRadius,
            sigmaY: blurRadius,
          ),
          child: IconButton(
            color: iconColor,
            onPressed: onPressed,
            icon: Icon(icon),
          ),
        ),
      ),
    );
  }
}
