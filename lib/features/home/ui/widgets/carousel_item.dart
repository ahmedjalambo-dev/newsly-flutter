import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newsly/core/widgets/error_image_widget.dart';
import 'package:newsly/core/widgets/placeholder_image_widget.dart';
import 'package:newsly/core/widgets/verified_icon.dart';

class CarouselItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String source;
  final String publishedAt;
  final void Function()? onTap;

  const   CarouselItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.source,
    required this.publishedAt,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Format the publishedAt date
    final formattedDate = _formatDate(publishedAt);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      child: Stack(
        children: [
          // Use CachedNetworkImage for better performance and caching
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorWidget: (context, url, error) => const ErrorImageWidget(),
              placeholder: (context, url) => const PlaceholderImageWidget(),
            ),
          ),
          // Overlay to make text readable
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black,
                ],
              ),
            ),
          ),

          // Title and formatted date
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Source and date
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Flexible(
                      child: Text(
                        source,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    VerifiedIcon(
                      size: 18,
                      checkColor: Colors.white,
                      circleColor: Theme.of(context).primaryColor,
                    ),
                    const Icon(
                      Icons.circle,
                      color: Colors.white,
                      size: 4,
                    ),
                    Text(
                      formattedDate,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),

                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      // Parse the ISO 8601 date string
      final publishedDate = DateTime.parse(dateString);
      // Get the current date and time
      final now = DateTime.now();
      // Calculate the difference in hours
      final differenceInHours = now.difference(publishedDate).inHours;

      // Return the difference in hours
      if (differenceInHours < 1) {
        return 'Just now';
      } else if (differenceInHours == 1) {
        return '1 hour ago';
      } else {
        return '$differenceInHours hours ago';
      }
    } catch (e) {
      // Return a fallback if parsing fails
      return 'Invalid date';
    }
  }
}
