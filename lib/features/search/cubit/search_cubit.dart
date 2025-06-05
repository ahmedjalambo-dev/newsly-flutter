import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:newsly/core/models/article_model.dart';
import 'package:newsly/features/search/data/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo searchRepo;
  String? _lastQuery;
  int _currentPage = 1;
  static const int _pageSize = 20;

  SearchCubit({required this.searchRepo})
      : super(SearchState(
            status: SearchStatus.initial, articles: null, errorMassage: null));

  Future<void> fetchSearchNews(String query) async {
    // Reset pagination when starting a new search
    _currentPage = 1;
    _lastQuery = query;
    emit(state.copyWith(status: SearchStatus.loading));

    final searchResult = await searchRepo.searchNews(
      query: query,
      page: _currentPage,
      pageSize: _pageSize,
    );

    if (searchResult.isSuccess) {
      final articles = searchResult.data ?? [];
      emit(state.copyWith(
        status: SearchStatus.loaded,
        articles: articles,
        hasMore: articles.length >= _pageSize,
      ));
    } else {
      emit(state.copyWith(
        status: SearchStatus.error,
        errorMassage: searchResult.error,
      ));
    }
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoading || _lastQuery == null) return;

    _currentPage++;
    emit(state.copyWith(status: SearchStatus.loadingMore));

    final searchResult = await searchRepo.searchNews(
      query: _lastQuery!,
      page: _currentPage,
      pageSize: _pageSize,
    );

    if (searchResult.isSuccess) {
      final newArticles = searchResult.data ?? [];
      final List<ArticleModel> updatedArticles = [
        ...(state.articles ?? []),
        ...newArticles,
      ];

      emit(state.copyWith(
        status: SearchStatus.loaded,
        articles: updatedArticles,
        hasMore: newArticles.length >= _pageSize,
      ));
    } else {
      // Revert page increment on error
      _currentPage--;
      emit(state.copyWith(
        status: SearchStatus.error,
        errorMassage: searchResult.error,
      ));
    }
  }

  Future<void> clearSearch() async {
    _lastQuery = null;
    _currentPage = 1;
    emit(state.copyWith(
      status: SearchStatus.initial,
      articles: null,
      errorMassage: null,
      hasMore: true,
    ));
  }
}
