import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/core/di/service_locator.dart';
import 'package:newsly/features/home/cubit/home_cubit.dart';
import 'package:newsly/features/details/ui/details_screen.dart';
import 'package:newsly/features/home/ui/widgets/carousel_item.dart';
import 'package:newsly/features/home/ui/widgets/carousel_with_indicator.dart';
import 'package:newsly/features/home/ui/widgets/category_tile.dart';
import 'package:newsly/core/widgets/circle_icon_button.dart';
import 'package:newsly/core/widgets/news_tile.dart';
import 'package:newsly/core/widgets/newsly_logo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<HomeCubit>(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Builder(builder: (context) => _buildBody(context)),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.isError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                spacing: 16,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.white,
                  ),
                  Flexible(
                      child: Text(
                    state.errorMassage ?? 'Something went wrong',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
                ],
              ),
              duration: const Duration(seconds: 20),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final breakingArticles = state.breakingNews ?? [];
          final recommendationArticles = state.recommendationNews ?? [];

          return RefreshIndicator(
            onRefresh: () => getIt<HomeCubit>().fetchHomeNews(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // Breaking News Section
                  const CategoryTile(
                    categoryName: 'Breaking News',
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  if (breakingArticles.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('No breaking news available.'),
                    )
                  else
                    CarouselWithIndicator(
                      items: breakingArticles.map((article) {
                        return CarouselItem(
                          imageUrl: article.urlToImage ??
                              'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png',
                          title: article.title ?? 'No title available',
                          publishedAt:
                              article.publishedAt ?? 'No date available',
                          source: article.source?.name ?? 'Unknown source',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailsScreen(article: article),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                  const SizedBox(height: 16),
                  const CategoryTile(
                    categoryName: 'Recommendation',
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  const SizedBox(height: 8),

                  if (recommendationArticles.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('No recommendations available.'),
                    )
                  else
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: recommendationArticles.length,
                      itemBuilder: (context, index) {
                        final article = recommendationArticles[index];
                        return InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailsScreen(article: article),
                            ),
                          ),
                          child: NewsTile(article: article, index: index),
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      scrolledUnderElevation: 0,
      title: const NewslyLogo(),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: [
              BlurCircleIconButton(
                icon: Icons.search,
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              BlurCircleIconButton(
                icon: Icons.dark_mode_outlined,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
