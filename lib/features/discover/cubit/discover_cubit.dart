// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

import 'package:newsly/features/discover/cubit/discover_state.dart';
import 'package:newsly/features/discover/data/repos/discover_repos.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  final DiscoverRepo discoverRepo;
  final String category;

  int _currentPage = 1;
  bool _isFetchingMore = false;
  bool _hasFetchedOnce = false;

  DiscoverCubit({
    required this.discoverRepo,
    required this.category,
  }) : super(DiscoverState(status: DiscoverStatus.loading));

  // called from didChangeDependencies
  void fetchIfNeeded() {
    if (!_hasFetchedOnce) {
      _hasFetchedOnce = true;
      fetchNews();
    }
  }

  Future<void> fetchNews() async {
    emit(state.copyWith(status: DiscoverStatus.loading));
    try {
      final articles = await discoverRepo.fetchNewsByCategory(
          category: category, page: _currentPage);
      emit(state.copyWith(status: DiscoverStatus.loaded, articles: articles));
    } catch (e) {
      emit(state.copyWith(
          status: DiscoverStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> fetchMore() async {
    if (_isFetchingMore) return;
    _isFetchingMore = true;
    _currentPage++;

    try {
      final moreArticles = await discoverRepo.fetchNewsByCategory(
          category: category, page: _currentPage);
      final updatedList = [...?state.articles, ...moreArticles];
      emit(state.copyWith(articles: updatedList));
    } catch (e) {
      // optionally handle pagination error
    } finally {
      _isFetchingMore = false;
    }
  }
}
