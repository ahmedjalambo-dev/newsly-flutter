import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/features/home/cubit/topheadlines_cubit.dart';
import 'package:newsly/features/home/ui/widgets/carousel_item.dart';
import 'package:newsly/features/home/ui/widgets/carousel_with_indicator.dart';
import 'package:newsly/features/home/ui/widgets/category_tile.dart';
import 'package:newsly/features/home/ui/widgets/circle_icon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            final articles = state.topheadlines.articles ?? [];
            return SingleChildScrollView(
              child: Column(
                children: [
                  const CategoryTile(
                      categoryName: 'Breaking News',
                      padding: EdgeInsets.only(top: 16, left: 16, right: 16)),
                  CarouselWithIndicator(
                    items: articles
                        .where((article) =>
                            article.urlToImage != null &&
                            article.urlToImage!.isNotEmpty)
                        .map((article) {
                      return CarouselItem(
                        imageUrl: article.urlToImage!,
                        title: article.title ?? '',
                        publishedAt: article.publishedAt ?? '',
                        source: article.source?.name ?? '',
                      );
                    }).toList(),
                  ),
                  const CategoryTile(
                      categoryName: 'Recommindation News',
                      padding: EdgeInsets.only(top: 16, left: 16, right: 16)),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                article.urlToImage ?? '',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
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
              CircleIconButton(
                icon: Icons.search_rounded,
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              CircleIconButton(
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
