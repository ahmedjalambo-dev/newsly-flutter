import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsly/common/functions.dart';
import 'package:newsly/features/home/data/models/article_model.dart';
import 'package:intl/intl.dart';
import 'package:newsly/features/home/ui/widgets/placeholder_image.dart';
import 'package:newsly/features/home/ui/widgets/verified_icon.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        spacing: 8,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: CachedNetworkImage(
              imageUrl: article.urlToImage!,
              width: MediaQuery.of(context).size.width * 0.3,
              height: 120,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const PlaceholderImage(),
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
                    Flexible(
                      child: Text(
                        validArticles[index].source?.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    VerifiedIcon(
                      size: 18,
                      circleColor: Theme.of(context).primaryColor,
                      checkColor: Colors.white,
                    ),
                  ],
                ),
                Text(
                  validArticles[index].title!,
                  overflow: TextOverflow.ellipsis,
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
                      DateFormat.yMMMd().format(
                          DateTime.parse(validArticles[index].publishedAt!)),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Text(
                        validArticles[index].author == null ||
                                validArticles[index].author == ""
                            ? '${validArticles[index].source?.name} group'
                            : (isURL(validArticles[index].author!)
                                ? '${validArticles[index].source?.name} group'
                                : extractFirstWord(
                                    validArticles[index].author!)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
