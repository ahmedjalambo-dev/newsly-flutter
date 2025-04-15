import 'package:flutter/material.dart';

class PlaceholderImageWidget extends StatelessWidget {
  const PlaceholderImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xffe0e0e0),
      ),
    );
  }
}
