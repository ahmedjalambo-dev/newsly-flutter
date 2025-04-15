import 'package:flutter/material.dart';

class ErrorImageWidget extends StatelessWidget {
  const ErrorImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png',
    );
  }
}
