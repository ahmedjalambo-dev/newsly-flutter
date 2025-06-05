part of 'search_cubit.dart';

enum SearchStatus { initial, loading, loadingMore, loaded, error }

extension SearchStatusX on SearchState {
  bool get isInitial => status == SearchStatus.initial;
  bool get isLoading => status == SearchStatus.loading;
  bool get isLoadingMore => status == SearchStatus.loadingMore;
  bool get isLoaded => status == SearchStatus.loaded;
  bool get isError => status == SearchStatus.error;
}

class SearchState {
  final SearchStatus status;
  final List<ArticleModel>? articles;
  final String? errorMassage;
  final bool hasMore;
  SearchState({
    required this.status,
    this.articles,
    this.errorMassage,
    this.hasMore = true,
  });

  SearchState copyWith({
    SearchStatus? status,
    List<ArticleModel>? articles,
    String? errorMassage,
    bool? hasMore,
  }) {
    return SearchState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
      errorMassage: errorMassage ?? this.errorMassage,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  String toString() {
    return 'SearchState(status: $status, articles: $articles, errorMassage: $errorMassage, hasMore: $hasMore)';
  }

  @override
  bool operator ==(covariant SearchState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        listEquals(other.articles, articles) &&
        other.errorMassage == errorMassage &&
        other.hasMore == hasMore;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        articles.hashCode ^
        errorMassage.hashCode ^
        hasMore.hashCode;
  }
}
