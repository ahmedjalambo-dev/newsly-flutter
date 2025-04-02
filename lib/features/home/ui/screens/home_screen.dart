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
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TopheadlinesCubit, TopheadlinesState>(
        builder: (context, state) {
          if (state is TopheadlinesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TopheadlinesError) {
            return Center(child: Text('Error: ${state.errorMassage}'));
          } else if (state is TopheadlinesLoaded) {
            final breakingArticles = state.breakingNews.articles ?? [];
            final validBreakingArticles = breakingArticles
                .where((article) =>
                    article.urlToImage != null &&
                    article.urlToImage!.isNotEmpty)
                .toList();

            final recommendationArticles =
                state.recommendationNews.articles ?? [];
            final validRecommendationArticles = recommendationArticles
                .where((article) =>
                    article.urlToImage != null &&
                    article.urlToImage!.isNotEmpty)
                .toList();

            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  title: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      'NEWSLY',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
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
                  floating: true,
                  snap: true,
                  pinned: false, // Key change
                  expandedHeight: 0, // Prevents any expanded state
                  backgroundColor:
                      Colors.white, // Set your app's background color
                  surfaceTintColor: Colors.white,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                ),
              ],
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const CategoryTile(
                          categoryName: 'Breaking News',
                          padding:
                              EdgeInsets.only(top: 16, left: 16, right: 16),
                        ),
                        CarouselWithIndicator(
                          items: validBreakingArticles.map((article) {
                            return InkWell(
                              onTap: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) {
                                    return DetailsScreen(
                                      article: article,
                                    );
                                  },
                                ),
                              ),
                              child: CarouselItem(
                                imageUrl: article.urlToImage!,
                                title: article.title ?? '',
                                publishedAt: article.publishedAt ?? '',
                                source: article.source?.name ?? '',
                              ),
                            );
                          }).toList(),
                        ),
                        const CategoryTile(
                          categoryName: 'Recommindation',
                          padding:
                              EdgeInsets.only(top: 16, left: 16, right: 16),
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final article = validRecommendationArticles[index];
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
                              validArticles: validRecommendationArticles,
                              index: index,
                            ),
                          ),
                        );
                      },
                      childCount: validRecommendationArticles.length,
                    ),
                  ),
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
}
