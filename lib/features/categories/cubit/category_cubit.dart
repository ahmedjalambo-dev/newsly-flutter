// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

import 'package:newsly/features/categories/cubit/category_state.dart';
import 'package:newsly/features/categories/data/repos/category_repos.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepo categoryRepo;
  final String category;

  int _currentPage = 1;
  bool _isFetchingMore = false;
  bool _hasFetchedOnce = false;

  CategoryCubit({
    required this.categoryRepo,
    required this.category,
  }) : super(CategoryState(status: CategoryStatus.loading));

  // called from didChangeDependencies
  void fetchIfNeeded() {
    if (!_hasFetchedOnce) {
      _hasFetchedOnce = true;
      fetchNews();
    }
  }

  /// Fetches news articles by category.
  Future<void> fetchNews() async {
    try {
      final articles = await categoryRepo.fetchNewsByCategory(
          category: category, page: _currentPage);
      emit(state.copyWith(status: CategoryStatus.loaded, articles: articles));
    } catch (e) {
      emit(state.copyWith(
          status: CategoryStatus.error, errorMessage: e.toString()));
    }
  }

  /// Fetches more articles for pagination.
  Future<void> fetchMore() async {
    if (_isFetchingMore) return;
    _isFetchingMore = true;
    _currentPage++;

    try {
      final moreArticles = await categoryRepo.fetchNewsByCategory(
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
