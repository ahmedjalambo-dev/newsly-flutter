import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/features/home/cubit/topheadlines_cubit.dart';
import 'package:newsly/features/home/ui/screens/details_screen.dart';
import 'package:newsly/features/home/ui/widgets/carousel_item.dart';
import 'package:newsly/features/home/ui/widgets/carousel_with_indicator.dart';
import 'package:newsly/features/home/ui/widgets/category_tile.dart';
import 'package:newsly/features/home/ui/widgets/circle_icon_button.dart';
import 'package:newsly/features/home/ui/widgets/news_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder<TopheadlinesCubit, TopheadlinesState>(
        builder: (context, state) {
          if (state is TopheadlinesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TopheadlinesError) {
            return Center(child: Text('Error: ${state.errorMassage}'));
          } else if (state is TopheadlinesLoaded) {
            final breackingArticles = state.breakingNews.articles ?? [];
            // Filter articles with valid urlToImage
            final validArticles = breackingArticles
                .where((article) =>
                    article.urlToImage != null &&
                    article.urlToImage!.isNotEmpty)
                .toList();
            return SingleChildScrollView(
              child: Column(
                children: [
                  const CategoryTile(
                    categoryName: 'Breaking News',
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                  ),
                  CarouselWithIndicator(
                    items: validArticles.map((article) {
                      return CarouselItem(
                        imageUrl: article.urlToImage!,
                        title: article.title ?? '',
                        publishedAt: article.publishedAt ?? '',
                        source: article.source?.name ?? '',
                      );
                    }).toList(),
                  ),
                  const CategoryTile(
                    categoryName: 'Recommindation',
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: validArticles.length,
                    itemBuilder: (context, index) {
                      final recommendationArticles =
                          state.recommendationNews.articles ?? [];
                      // Filter articles with valid urlToImage
                      final validArticles = recommendationArticles
                          .where((article) =>
                              article.urlToImage != null &&
                              article.urlToImage!.isNotEmpty)
                          .toList();
                      final article = validArticles[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: InkWell(
                          onTap: () =>
                              Navigator.push(context, CupertinoPageRoute(
                            builder: (context) {
                              return DetailsScreen(
                                article: article,
                              );
                            },
                          )),
                          child: NewsTile(
                            article: article,
                            validArticles: validArticles,
                            index: index,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        'Newsly',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: [
              BlurCircleIconButton(
                icon: Icons.search_rounded,
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              BlurCircleIconButton(
                icon: Icons.notifications_none_rounded,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
