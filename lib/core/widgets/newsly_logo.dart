import 'package:flutter/material.dart';

class NewslyLogo extends StatelessWidget {
  const NewslyLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'NEWSLY',
      style: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 28,
        fontWeight: FontWeight.w900,
        color: Colors.blue,
      ),
    );
  }
}
