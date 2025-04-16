import 'package:flutter/foundation.dart';

import 'package:newsly/core/models/article_model.dart';

enum CategoryStatus { loading, loaded, error }

extension CategoryStatusX on CategoryState {
  bool get isLoading => status == CategoryStatus.loading;
  bool get isLoaded => status == CategoryStatus.loaded;
  bool get isError => status == CategoryStatus.error;
}

class CategoryState {
  final CategoryStatus status;
  final List<ArticleModel>? articles;
  final String? errorMessage;
  final bool hasMore;
  CategoryState({
    required this.status,
    this.articles,
    this.errorMessage,
    this.hasMore = true,
  });

  CategoryState copyWith({
    CategoryStatus? status,
    List<ArticleModel>? articles,
    String? errorMessage,
    bool? hasMore,
  }) {
    return CategoryState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
      errorMessage: errorMessage ?? this.errorMessage,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  String toString() {
    return 'CategoryState(status: $status, articles: $articles, errorMessage: $errorMessage, hasMore: $hasMore)';
  }

  @override
  bool operator ==(covariant CategoryState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        listEquals(other.articles, articles) &&
        other.errorMessage == errorMessage &&
        other.hasMore == hasMore;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        articles.hashCode ^
        errorMessage.hashCode ^
        hasMore.hashCode;
  }
}
