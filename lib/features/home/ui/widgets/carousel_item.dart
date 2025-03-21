import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarouselItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String source;
  final String publishedAt;

  const CarouselItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.source,
    required this.publishedAt,
  });

  @override
  Widget build(BuildContext context) {
    // Format the publishedAt date
    final formattedDate = _formatDate(publishedAt);

    return Stack(
      children: [
        // Use CachedNetworkImage for better performance and caching
        imageUrl.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  placeholder: (context, url) =>
                      _buildPlaceholderImage(), // Show placeholder while loading
                  errorWidget: (context, url, error) =>
                      _buildPlaceholderImage(), // Show placeholder on error
                ),
              )
            : _buildPlaceholderImage(), // Show placeholder if URL is empty
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
              // Formatted date
              Row(
                spacing: 4,
                children: [
                  Text(
                    source,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const Stack(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.white,
                        size: 18,
                      ),
                      Icon(
                        Icons.check_circle_rounded,
                        color: Colors.blue,
                        size: 18,
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.circle,
                    color: Colors.white,
                    size: 4,
                  ),
                  Text(
                    formattedDate,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
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
    );
  }

  // Placeholder image widget
  Widget _buildPlaceholderImage() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Center(
        child: Icon(
          Icons.image,
          color: Colors.grey,
          size: 48,
        ),
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
