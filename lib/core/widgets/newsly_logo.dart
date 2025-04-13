import 'package:flutter/material.dart';

class NewslyLogo extends StatelessWidget {
  const NewslyLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Text(
        'NEWSLY',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
