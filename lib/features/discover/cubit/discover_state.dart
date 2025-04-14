import 'package:flutter/foundation.dart';

import 'package:newsly/core/models/article_model.dart';

enum DiscoverStatus { loading, loaded, error }

extension DiscoverStatusX on DiscoverState {
  bool get isLoading => status == DiscoverStatus.loading;
  bool get isLoaded => status == DiscoverStatus.loaded;
  bool get isError => status == DiscoverStatus.error;
}

class DiscoverState {
  final DiscoverStatus status;
  final List<ArticleModel>? articles;
  final String? errorMessage;
  DiscoverState({
    required this.status,
    this.articles,
    this.errorMessage,
  });

  DiscoverState copyWith({
    DiscoverStatus? status,
    List<ArticleModel>? articles,
    String? errorMessage,
  }) {
    return DiscoverState(
      status: status ?? this.status,
      articles: articles ?? articles,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() =>
      'DiscoverState(status: $status, articles: $articles, errorMessage: $errorMessage)';

  @override
  bool operator ==(covariant DiscoverState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        listEquals(other.articles, articles) &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      status.hashCode ^ articles.hashCode ^ errorMessage.hashCode;
}
