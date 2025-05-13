import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsly/core/functions.dart';
import 'package:newsly/core/models/article_model.dart';
import 'package:intl/intl.dart';
import 'package:newsly/core/widgets/error_image_widget.dart';
import 'package:newsly/core/widgets/placeholder_image_widget.dart';
import 'package:newsly/core/widgets/verified_icon.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({
    super.key,
    required this.article,
    required this.index,
  });

  final ArticleModel article;
  final int index;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 400;
        final imageWidth = isSmallScreen
            ? constraints.maxWidth * 0.35
            : constraints.maxWidth * 0.3;
        final textWidth = isSmallScreen
            ? constraints.maxWidth * 0.55
            : constraints.maxWidth * 0.6;
        final imageHeight = isSmallScreen ? 90.0 : 120.0;
        final titleFontSize = isSmallScreen ? 15.0 : 18.0;
        final metaFontSize = isSmallScreen ? 12.0 : 14.0;
        final borderRadius = isSmallScreen ? 16.0 : 25.0;
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 8 : 16,
            vertical: isSmallScreen ? 4 : 8,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage ??
                      'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png',
                  width: imageWidth,
                  height: imageHeight,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                      const ErrorImageWidget(),
                  placeholder: (context, url) => const PlaceholderImageWidget(),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: textWidth,
                height: imageHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            article.source?.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: metaFontSize,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                        if (!isSmallScreen) ...[
                          const SizedBox(width: 4),
                          VerifiedIcon(
                            size: 18,
                            circleColor: Theme.of(context).primaryColor,
                            checkColor: Colors.white,
                          ),
                        ],
                      ],
                    ),
                    Expanded(
                      child: Text(
                        article.title ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: isSmallScreen ? 2 : 3,
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          DateFormat.yMMMd().format(DateTime.parse(
                              article.publishedAt ??
                                  DateTime.now().toString())),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: metaFontSize,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.circle,
                          color: Colors.grey.shade600,
                          size: 4,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            article.author == null || article.author == ""
                                ? '${article.source?.name} group'
                                : (isURL(article.author!)
                                    ? '${article.source?.name} group'
                                    : extractFirstWord(article.author!)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: metaFontSize,
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
      },
    );
  }
}
