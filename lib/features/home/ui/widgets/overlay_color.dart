import 'package:flutter/material.dart';

class OverlayColor extends StatelessWidget {
  const OverlayColor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          gradient: LinearGradient(
            end: AlignmentDirectional.bottomCenter,
            begin: AlignmentDirectional.topCenter,
            colors: [
              Colors.black54,
              Colors.black45,
              Colors.black38,
              Colors.black26,
              Colors.black12,
              Colors.black26,
              Colors.black38,
              Colors.black45,
              Colors.black54,
            ],
          ),
        ),
      ),
    );
  }
}
