import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:newsly/core/models/news_model.dart';
import 'package:newsly/features/home/data/repos/news_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final NewsRepo newsRepo;

  HomeCubit({required this.newsRepo})
      : super(HomeState(status: HomeStatus.loading));

  Future<void> fetchHomeNews() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final breakingNews = await newsRepo.getBreakingNews();
      final recommendationNews = await newsRepo.getRecommendationNews();
      emit(
        state.copyWith(
          status: HomeStatus.loaded,
          breakingNews: breakingNews,
          recommendationNews: recommendationNews,
        ),
      );
      log('fetching news successful in cubit');
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.error,
          errorMassage: 'Failed to Fetch News: $e',
        ),
      );
      log('Error fetching news in cubit: $e');
    }
  }
}
