import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:newsly/core/models/article_model.dart';
import 'package:newsly/features/home/data/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo newsRepo;

  HomeCubit({required this.newsRepo})
      : super(HomeState(status: HomeStatus.loading));

  Future<void> fetchHomeNews() async {
    final breakingNewsResult = await newsRepo.getBreakingNews();
    final recommendationNewsResult = await newsRepo.getRecommendationNews();
    if (breakingNewsResult.isSuccess && recommendationNewsResult.isSuccess) {
      emit(state.copyWith(
        status: HomeStatus.loaded,
        breakingNews: breakingNewsResult.data,
        recommendationNews: recommendationNewsResult.data,
      ));
    } else {
      emit(state.copyWith(
        status: HomeStatus.error,
        errorMassage: breakingNewsResult.error ??
            recommendationNewsResult.error ??
            'Unknown error occurred',
      ));
    }
  }
}
