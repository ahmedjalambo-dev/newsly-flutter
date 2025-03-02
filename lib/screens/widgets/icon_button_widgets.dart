import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;

  const IconButtonWidget({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFE9E9E9),
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        color: Colors.black,
        onPressed: onPressed,
        icon: Icon(icon),
      ),
    );
  }
}
