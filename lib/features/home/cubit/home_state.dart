part of 'home_cubit.dart';

enum HomeStatus { loading, loaded, error }

extension HomeStatusX on HomeState {
  bool get isLoading => status == HomeStatus.loading;
  bool get isLoaded => status == HomeStatus.loaded;
  bool get isError => status == HomeStatus.error;
}

class HomeState {
  final HomeStatus status;
  final List<ArticleModel>? breakingNews;
  final List<ArticleModel>? recommendationNews;
  final String? errorMassage;
  HomeState({
    required this.status,
    this.breakingNews,
    this.recommendationNews,
    this.errorMassage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<ArticleModel>? breakingNews,
    List<ArticleModel>? recommendationNews,
    String? errorMassage,
  }) {
    return HomeState(
      status: status ?? this.status,
      breakingNews: breakingNews ?? this.breakingNews,
      recommendationNews: recommendationNews ?? this.recommendationNews,
      errorMassage: errorMassage ?? this.errorMassage,
    );
  }

  @override
  String toString() {
    return 'HomeState(status: $status, breakingNews: $breakingNews, recommendationNews: $recommendationNews, errorMassage: $errorMassage)';
  }

  @override
  bool operator ==(covariant HomeState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        listEquals(other.breakingNews, breakingNews) &&
        listEquals(other.recommendationNews, recommendationNews) &&
        other.errorMassage == errorMassage;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        breakingNews.hashCode ^
        recommendationNews.hashCode ^
        errorMassage.hashCode;
  }
}
