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

  Future<void> fetchTopHeadlines() async {
    emit(const TopheadlinesLoading());
    try {
      final topheadlines = await topHeadlineRepo.getTopHeadlines();
      emit(TopheadlinesLoaded(topheadlines: topheadlines));
    } catch (e) {
      emit(TopheadlinesError(errorMassage: 'Failed to load top headlines: $e'));
    }
  }
}
