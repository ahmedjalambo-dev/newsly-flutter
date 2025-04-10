import 'package:flutter/material.dart';

class PlaceholderImage extends StatelessWidget {
  const PlaceholderImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Center(
        child: Icon(
          Icons.image,
          color: Colors.grey,
          size: 48,
        ),
      ),
    );
  }
}
