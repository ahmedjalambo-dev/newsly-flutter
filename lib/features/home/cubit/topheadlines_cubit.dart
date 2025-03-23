import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:newsly/features/home/db/models/topheadline_model.dart';
import 'package:newsly/features/home/db/repos/topheadline_repo.dart';

part 'topheadlines_state.dart';

class TopheadlinesCubit extends Cubit<TopheadlinesState> {
  final TopHeadlineRepo topHeadlineRepo;

  TopheadlinesCubit({required this.topHeadlineRepo})
      : super(const TopheadlinesLoading());

  Future<void> fetchNews() async {
    emit(const TopheadlinesLoading());
    try {
      final breakingNews = await topHeadlineRepo.getBreakingNews();
      final recommendationNews = await topHeadlineRepo.getRecommendationNews();
      emit(TopheadlinesLoaded(
          breakingNews: breakingNews, recommendationNews: recommendationNews));
    } catch (e) {
      emit(TopheadlinesError(errorMassage: 'Failed to load top headlines: $e'));
    }
  }
}
