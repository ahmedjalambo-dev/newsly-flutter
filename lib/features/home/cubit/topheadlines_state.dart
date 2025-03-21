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
  final TopheadlineModel topheadlines;

  const TopheadlinesLoaded({required this.topheadlines});
  @override
  List<Object?> get props => [topheadlines];
}

final class TopheadlinesError extends TopheadlinesState {
  final String errorMassage;

  const TopheadlinesError({required this.errorMassage});
  @override
  List<Object?> get props => [errorMassage];
}
