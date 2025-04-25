import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/core/widgets/news_tile.dart';
import 'package:newsly/features/details/ui/details_screen.dart';
import 'package:newsly/features/categories/cubit/category_cubit.dart';
import 'package:newsly/features/categories/cubit/category_state.dart';

class NewsCategoryTabView extends StatefulWidget {
  final String category;
  const NewsCategoryTabView({super.key, required this.category});

  @override
  State<NewsCategoryTabView> createState() => _NewsCategoryTabViewState();
}

class _NewsCategoryTabViewState extends State<NewsCategoryTabView>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController _scrollController;
  late final CategoryCubit categoryCubit;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categoryCubit = context.read<CategoryCubit>();
    categoryCubit.fetchIfNeeded();
  }

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        categoryCubit.fetchMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocConsumer<CategoryCubit, CategoryState>(
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
                    state.errorMessage ?? 'Something went wrong',
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
        final categoryNews = state.articles ?? [];

        if (state.isLoading && categoryNews.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (categoryNews.isEmpty) {
          return RefreshIndicator(
            onRefresh: () => categoryCubit.fetchNews(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    MediaQuery.of(context).padding.top,
                child: const Center(
                  child: Text('No News available'),
                ),
              ),
            ),
          );
        }

        return RefreshIndicator(
            onRefresh: () async {
              if (state.hasMore == false) {
                // Reset the current page and hasMore flag
                categoryCubit.resetPagination();
                // Fetch the news again
                await categoryCubit.fetchNews();
              } else {
                // If there are more articles, just fetch again
                await categoryCubit.fetchNews();
              }
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: categoryNews.length + 1, // extra item at end
              itemBuilder: (_, i) {
                if (i < categoryNews.length) {
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsScreen(article: categoryNews[i]),
                      ),
                    ),
                    child: NewsTile(article: categoryNews[i], index: i),
                  );
                } else {
                  if (!state.hasMore) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Icon(
                          Icons.circle,
                          size: 12,
                          color: Colors.blue[200],
                        ),
                      ),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                }
              },
            ));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
