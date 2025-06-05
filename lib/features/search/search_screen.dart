import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/core/di/service_locator.dart';
import 'package:newsly/core/widgets/news_tile.dart';
import 'package:newsly/features/details/ui/details_screen.dart';
import 'package:newsly/features/search/cubit/search_cubit.dart';
import 'package:newsly/core/cache/shared_prefs_helper.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const String _recentSearchesKey = 'recent_searches';
  static const int _maxRecentSearches = 5;

  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showClearButton = false;
  List<String> _recentSearches = [];

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
    getIt<SearchCubit>().clearSearch(); // Clear any previous search state
    _searchController.addListener(() =>
        setState(() => _showClearButton = _searchController.text.isNotEmpty));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    getIt<SearchCubit>().clearSearch(); // Clear search state when leaving
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        getIt<SearchCubit>().loadMore();
      }
    }
  }

  Future<void> _loadRecentSearches() async {
    final prefs = getIt<SharedPrefsHelper>();
    final searches = prefs.getData<List<String>>(key: _recentSearchesKey) ?? [];
    setState(() => _recentSearches = searches);
  }

  Future<void> _saveRecentSearch(String query) async {
    if (query.trim().isEmpty) return;

    final prefs = getIt<SharedPrefsHelper>();
    _recentSearches.remove(query); // Remove if exists
    _recentSearches.insert(0, query); // Add to start

    if (_recentSearches.length > _maxRecentSearches) {
      _recentSearches = _recentSearches.take(_maxRecentSearches).toList();
    }
    await prefs.saveData(key: _recentSearchesKey, value: _recentSearches);
    setState(() {});
  }

  Future<void> _removeRecentSearch(String query) async {
    final prefs = getIt<SharedPrefsHelper>();
    setState(() => _recentSearches.remove(query));
    await prefs.saveData(key: _recentSearchesKey, value: _recentSearches);
  }

  void _handleSearch(String query, BuildContext context) {
    if (query.trim().isNotEmpty) {
      _saveRecentSearch(query);
      context.read<SearchCubit>().fetchSearchNews(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<SearchCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
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
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      snap: true,
                      scrolledUnderElevation: 0,
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          context.read<SearchCubit>().clearSearch();
                          Navigator.pop(context);
                        },
                      ),
                      title: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search for news...',
                            suffixIcon: _showClearButton
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      _searchController.clear();
                                      context.read<SearchCubit>().clearSearch();
                                    },
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
                    if (state.isLoading)
                      const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (state.isInitial && _recentSearches.isNotEmpty)
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (index == 0) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Recent Searches',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        final prefs =
                                            getIt<SharedPrefsHelper>();
                                        await prefs.removeData(
                                            key: _recentSearchesKey);
                                        setState(() {
                                          _recentSearches.clear();
                                        });
                                      },
                                      child: const Text('Clear All'),
                                    ),
                                  ],
                                ),
                              );
                            }
                            final search = _recentSearches[index - 1];
                            return ListTile(
                              leading: const Icon(Icons.history),
                              title: Text(search),
                              trailing: IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () => _removeRecentSearch(search),
                              ),
                              onTap: () {
                                _searchController.text = search;
                                _handleSearch(search, context);
                              },
                            );
                          },
                          childCount: _recentSearches.length + 1,
                        ),
                      )
                    else if (state.isLoaded &&
                        (state.articles?.isNotEmpty ?? false))
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (index >= (state.articles?.length ?? 0)) {
                              // Show bottom loader
                              return Visibility(
                                visible: state.isLoadingMore,
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              );
                            }

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
                          // Add +1 to childCount for the loader item
                          childCount: (state.articles?.length ?? 0) +
                              (state.hasMore ? 1 : 0),
                        ),
                      )
                    else if (state.isLoaded)
                      const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text('No results found'),
                        ),
                      )
                    else if (state.isInitial && _recentSearches.isEmpty)
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
