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
  CategoryState({
    required this.status,
    this.articles,
    this.errorMessage,
  });

  CategoryState copyWith({
    CategoryStatus? status,
    List<ArticleModel>? articles,
    String? errorMessage,
  }) {
    return CategoryState(
      status: status ?? this.status,
      articles: articles ?? articles,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() =>
      ' CategoryState(status: $status, articles: $articles, errorMessage: $errorMessage)';

  @override
  bool operator ==(covariant CategoryState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        listEquals(other.articles, articles) &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      status.hashCode ^ articles.hashCode ^ errorMessage.hashCode;
}
