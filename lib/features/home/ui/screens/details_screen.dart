import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsly/features/home/db/models/article_model.dart';
import 'package:newsly/features/home/ui/widgets/circle_icon_button.dart';
import 'package:newsly/features/home/ui/widgets/overlay_color.dart';
import 'package:newsly/features/home/ui/widgets/verified_icon.dart';

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
    return Scaffold(
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
                    imageUrl: widget.article.urlToImage ?? '',
                    fit: BoxFit.cover,
                    height: MediaQuery.sizeOf(context).height * 0.3,
                  ),
                  const OverlayColor(
                    gradientColors: [
                      Colors.black38,
                      Colors.black38,
                      Colors.black38,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black38,
                      Colors.black38,
                      Colors.black38,
                      Colors.black87,
                      Colors.black87,
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
                  Positioned(
                    top: 35,
                    right: 16,
                    child: BlurCircleIconButton(
                      icon: Icons.bookmark_border_rounded,
                      iconColor: Colors.white,
                      blurRadius: 10,
                      circleColor: const Color.fromARGB(10, 0, 0, 0),
                      onPressed: () {},
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.sizeOf(context).height * 0.05,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          child: Text(
                            widget.article.title ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          spacing: 8,
                          children: [
                            Text(
                              widget.article.author ?? '',
                              maxLines: 1,
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
                            Text(
                              DateFormat.yMMMd().format(
                                  DateTime.parse(widget.article.publishedAt!)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
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
                spacing: 16,
                children: [
                  Row(
                    spacing: 6,
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/images/cnn.png'),
                      ),
                      Text(
                        widget.article.source!.name ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const VerifiedIcon(
                        size: 24,
                        checkColor: Colors.white,
                        circleColor: Colors.blue,
                      ),
                    ],
                  ),
                  Text(
                    widget.article.description!,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
