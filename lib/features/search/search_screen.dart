import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/core/di/service_locator.dart';
import 'package:newsly/core/widgets/news_tile.dart';
import 'package:newsly/features/details/ui/details_screen.dart';
import 'package:newsly/features/search/cubit/search_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _showClearButton = _searchController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch(String query, BuildContext context) {
    if (query.trim().isNotEmpty) {
      context.read<SearchCubit>().fetchSearchNews(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SearchCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: BlocConsumer<SearchCubit, SearchState>(
              listener: (context, state) {
                if (state.isError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.error_outline, color: Colors.white),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              state.errorMassage ?? 'Something went wrong',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      duration: const Duration(seconds: 5),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      snap: true,
                      scrolledUnderElevation: 0,
                      title: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search for news...',
                            suffixIcon: _showClearButton
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () => _searchController.clear(),
                                  )
                                : null,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) => _handleSearch(value, context),
                        ),
                      ),
                    ),
                    if (state.isLoading && _searchController.text.isNotEmpty)
                      const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (state.isLoaded &&
                        (state.articles?.isNotEmpty ?? false))
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final article = state.articles![index];
                            return InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DetailsScreen(article: article),
                                ),
                              ),
                              child: NewsTile(article: article, index: index),
                            );
                          },
                          childCount: state.articles?.length ?? 0,
                        ),
                      )
                    else if (state.isLoaded &&
                        _searchController.text.isNotEmpty)
                      const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text('No results found'),
                        ),
                      )
                    else
                      const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text('Start typing to search news'),
                        ),
                      ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
