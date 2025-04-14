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
              content: Text(state.errorMassage!),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final breakingArticles = state.breakingNews!.articles ?? [];

          final recommendationArticles =
              state.recommendationNews!.articles ?? [];

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // Breaking News Section
                const CategoryTile(
                  categoryName: 'Breaking News',
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
                CarouselWithIndicator(
                  items: breakingArticles.map((article) {
                    return CarouselItem(
                      imageUrl:
                          article.urlToImage ?? 'assets/images/not-founded.png',
                      title: article.title ?? '',
                      publishedAt: article.publishedAt ?? '',
                      source: article.source?.name ?? '',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(article: article),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                // Recommendation Section
                const SizedBox(height: 16),
                const CategoryTile(
                  categoryName: 'Recommindation',
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
                const SizedBox(height: 8),

                // List of recommendation articles
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(), // important!
                  shrinkWrap: true, // important!
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
                      child: NewsTile(
                        article: article,
                        index: index,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),
              ],
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
