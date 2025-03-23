part of 'topheadlines_cubit.dart';

@immutable
sealed class TopheadlinesState extends Equatable {
  const TopheadlinesState();
}

final class TopheadlinesLoading extends TopheadlinesState {
  const TopheadlinesLoading();
  @override
  List<Object?> get props => [];
}

final class TopheadlinesLoaded extends TopheadlinesState {
  final TopheadlineModel breakingNews;
  final TopheadlineModel recommendationNews;

  const TopheadlinesLoaded({
    required this.breakingNews,
    required this.recommendationNews,
  });

  @override
  List<Object> get props => [breakingNews, recommendationNews];
}

final class TopheadlinesError extends TopheadlinesState {
  final String errorMassage;

  const TopheadlinesError({required this.errorMassage});
  @override
  List<Object?> get props => [errorMassage];
}
