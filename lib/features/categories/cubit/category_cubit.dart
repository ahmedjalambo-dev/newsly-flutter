import 'package:bloc/bloc.dart';
import 'package:newsly/features/categories/cubit/category_state.dart';
import 'package:newsly/features/categories/data/category_repo.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepo categoryRepo;
  final String category;

  int _currentPage = 1;
  bool _isFetchingMore = false;
  bool _hasFetchedOnce = false;
  bool _hasMore = true;

  CategoryCubit({
    required this.categoryRepo,
    required this.category,
  }) : super(CategoryState(status: CategoryStatus.loading));

  /// called from didChangeDependencies
  void fetchIfNeeded() {
    if (!_hasFetchedOnce) {
      _hasFetchedOnce = true;
      fetchNews();
    }
  }

  /// Fetches news articles by category.
  Future<void> fetchNews() async {
    final result = await categoryRepo.fetchNewsByCategory(
        category: category, page: _currentPage);
    if (result.isSuccess) {
      emit(state.copyWith(
        status: CategoryStatus.loaded,
        articles: result.data,
      ));
    } else {
      emit(state.copyWith(
        status: CategoryStatus.error,
        errorMessage: result.error ?? 'Unknown error oucurred',
      ));
    }
  }

  /// Fetches more articles for pagination.
  Future<void> fetchMore() async {
    if (_isFetchingMore || !_hasMore) return;
    _isFetchingMore = true;
    _currentPage++;

    try {
      final moreResult = await categoryRepo.fetchNewsByCategory(
          category: category, page: _currentPage);
      if (moreResult.isSuccess) {
        _hasMore = false; // No more pages to fetch
      }
      final updatedResult = [...?state.articles, ...?moreResult.data];
      emit(state.copyWith(
        status: CategoryStatus.loaded,
        articles: updatedResult,
        hasMore: _hasMore,
      ));
    } finally {
      _isFetchingMore = false;
    }
  }

  /// Resets the pagination state.
  void resetPagination() {
    _currentPage = 1;
    _hasMore = true; // Reset the hasMore flag
    _isFetchingMore = false; // Reset the fetching state
    emit(state.copyWith(
      status: CategoryStatus.loaded,
      hasMore: true,
    ));
  }
}
