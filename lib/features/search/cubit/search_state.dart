part of 'search_cubit.dart';

enum SearchStatus { loading, loaded, error }

extension SearchStatusX on SearchState {
  bool get isLoading => status == SearchStatus.loading;
  bool get isLoaded => status == SearchStatus.loaded;
  bool get isError => status == SearchStatus.error;
}

class SearchState {
  final SearchStatus status;
  final List<ArticleModel>? articles;
  final String? errorMassage;

  SearchState({
    required this.status,
    this.articles,
    this.errorMassage,
  });

  factory SearchState.loading() {
    return SearchState(
      status: SearchStatus.loading,
    );
  }

  factory SearchState.loaded(List<ArticleModel> articles) {
    return SearchState(
      status: SearchStatus.loaded,
      articles: articles,
    );
  }

  factory SearchState.error(String message) {
    return SearchState(
      status: SearchStatus.error,
      errorMassage: message,
    );
  }

  SearchState copyWith({
    SearchStatus? status,
    List<ArticleModel>? articles,
    String? errorMassage,
  }) {
    return SearchState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
      errorMassage: errorMassage ?? this.errorMassage,
    );
  }

  @override
  String toString() =>
      'SearchState(status: $status, articles: $articles, errorMassage: $errorMassage)';

  @override
  bool operator ==(covariant SearchState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        listEquals(other.articles, articles) &&
        other.errorMassage == errorMassage;
  }

  @override
  int get hashCode =>
      status.hashCode ^ articles.hashCode ^ errorMassage.hashCode;
}
