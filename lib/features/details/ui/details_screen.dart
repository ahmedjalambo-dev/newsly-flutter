import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:newsly/core/di/service_locator.dart';
import 'package:newsly/core/functions.dart';
import 'package:newsly/core/widgets/error_image_widget.dart';
import 'package:newsly/core/widgets/placeholder_image_widget.dart';
import 'package:newsly/features/bookmark/cubit/bookmark_cubit.dart';
import 'package:newsly/core/models/article_model.dart';
import 'package:newsly/core/widgets/circle_icon_button.dart';
import 'package:newsly/features/home/ui/widgets/overlay_color.dart';
import 'package:newsly/core/widgets/verified_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatefulWidget {
  final ArticleModel article;
  const DetailsScreen({
    super.key,
    required this.article,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<BookmarkCubit>(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: MediaQuery.sizeOf(context).height * 0.55,
              backgroundColor: Colors.white,
              elevation: 0.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                ],
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.article.urlToImage ??
                          'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png',
                      fit: BoxFit.cover,
                      height: MediaQuery.sizeOf(context).height * 0.3,
                      errorWidget: (context, url, error) =>
                          const ErrorImageWidget(),
                      placeholder: (context, url) =>
                          const PlaceholderImageWidget(),
                    ),
                    const OverlayColor(
                      gradientColors: [
                        Colors.black54,
                        Colors.black38,
                        Colors.transparent,
                        Colors.black54,
                        Colors.black,
                      ],
                    ),

                    // Back button
                    Positioned(
                      top: 35,
                      left: 16,
                      child: BlurCircleIconButton(
                        icon: Icons.arrow_back,
                        iconColor: Colors.white,
                        blurRadius: 10,
                        circleColor: const Color.fromARGB(10, 0, 0, 0),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    // Bookmark button
                    Positioned(
                      top: 35,
                      right: 16,
                      child: BlurCircleIconButton(
                        icon: widget.article.isBookmark == false
                            ? Icons.bookmark_outline_rounded
                            : Icons.bookmark_outlined,
                        iconColor: Colors.white,
                        blurRadius: 10,
                        circleColor: const Color.fromARGB(10, 0, 0, 0),
                        onPressed: () {
                          if (widget.article.isBookmark == false) {
                            getIt<BookmarkCubit>().addBookmark(widget.article);
                            setState(() => widget.article.isBookmark = true);
                          } else {
                            getIt<BookmarkCubit>()
                                .removeBookmark(widget.article);
                            setState(() => widget.article.isBookmark = false);
                          }
                        },
                      ),
                    ),

                    // Article title and metadata
                    Positioned(
                      bottom: MediaQuery.sizeOf(context).height * 0.05,
                      left: 16,
                      right: 16, // Add right constraint to limit width
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.sizeOf(context).width -
                              32, // left + right padding
                        ),
                        child: Column(
                          spacing: 8,
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // Align text to start
                          children: [
                            // Title
                            Text(
                              widget.article.title ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(1.0, 1.0),
                                    blurRadius: 3.0,
                                    color: Colors.black.withAlpha(150),
                                  ),
                                ],
                              ),
                            ),

                            // Author and date
                            Row(
                              spacing: 4,
                              children: [
                                Text(
                                  widget.article.author != null
                                      ? (isURL(widget.article.author!)
                                          ? 'Team'
                                          : extractFirstWord(
                                              widget.article.author!))
                                      : 'Team',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                const Icon(
                                  Icons.circle,
                                  color: Colors.white,
                                  size: 4,
                                ),
                                Flexible(
                                  child: Text(
                                    DateFormat.yMMMd().format(DateTime.parse(
                                        widget.article.publishedAt!)),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0.0),
                child: Container(
                  height: 25,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align content to start
                  children: [
                    // Source name and verified icon
                    Row(
                      spacing: 4,
                      children: [
                        Flexible(
                          child: Text(
                            widget.article.source?.name ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        VerifiedIcon(
                          size: 24,
                          checkColor: Colors.white,
                          circleColor: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),

                    const SizedBox(height: 16), // Replaced spacing parameter

                    // Article content
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          // fontFamily: 'Raleway',
                          fontSize: 22,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text:
                                '${widget.article.title ?? ''}\n', // Added null check
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight:
                                  FontWeight.bold, // Added for better hierarchy
                            ),
                          ),
                          const WidgetSpan(
                            child: SizedBox(
                                height:
                                    8), // Space between title and description
                          ),
                          TextSpan(
                            text: widget.article.description ??
                                '', // Added null check
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 18, // Slightly smaller than title
                              height: 1.4, // Better line height
                            ),
                          ),
                          TextSpan(
                            text: '  ...see more',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                if (widget.article.url != null) {
                                  launchUrl(Uri.parse(widget.article.url!));
                                }
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
