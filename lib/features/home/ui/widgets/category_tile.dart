import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String categoryName;
  final EdgeInsetsGeometry padding;

  const CategoryTile({
    super.key,
    required this.categoryName,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            categoryName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          // View more
          TextButton(
            onPressed: () {},
            child: const Text(
              'View all',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
