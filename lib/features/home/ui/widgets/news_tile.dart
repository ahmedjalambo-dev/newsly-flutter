import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsly/features/home/db/models/article_model.dart';
import 'package:intl/intl.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({
    super.key,
    required this.article,
    required this.validArticles,
    required this.index,
  });

  final ArticleModel article;
  final List<ArticleModel> validArticles;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: CachedNetworkImage(
            imageUrl: article.urlToImage!,
            width: MediaQuery.of(context).size.width * 0.3,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 4,
                children: [
                  Text(
                    validArticles[index].source?.name ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              Text(
                validArticles[index].title!,
                overflow: TextOverflow.clip,
                maxLines: 3,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                spacing: 8,
                children: [
                  Text(
                    validArticles[index].author != null
                        ? extractFirstWord(validArticles[index].author!)
                        : '${validArticles[index].source?.name} group',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Icon(
                    Icons.circle,
                    color: Colors.grey.shade600,
                    size: 4,
                  ),
                  Text(
                    DateFormat.yMMMd().format(
                        DateTime.parse(validArticles[index].publishedAt!)),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String extractFirstWord(String input) {
    // Define a regex pattern to match the first word before a comma or a space followed by a lowercase letter
    final regex = RegExp(r'^[^, ]+');

    // Find the first match in the input string
    final match = regex.firstMatch(input);

    // Return the matched group or an empty string if no match is found
    return match?.group(0) ?? '';
  }
}
